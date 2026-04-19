-- Aurora RP - Jobs Menu
-- Beautiful profession selection menu with realistic roles

local jobCategories = {
    ["Службы порядка"] = {
        {name = "Полицейский", model = "models/player/police.mdl", salary = 500, armor = 100, weapons = {"weapon_pistol", "weapon_stunstick"}, description = "Защита порядка и безопасности города"},
        {name = "Шериф", model = "models/player/police.mdl", salary = 700, armor = 100, weapons = {"weapon_pistol", "weapon_smg1"}, description = "Глава полицейского департамента"},
        {name = "SWAT", model = "models/player/swat.mdl", salary = 600, armor = 150, weapons = {"weapon_ar2", "weapon_pistol"}, description = "Спецназ для особых операций"}
    },
    ["Медицина"] = {
        {name = "Врач", model = "models/player/group03/female_02.mdl", salary = 450, armor = 50, weapons = {"weapon_medkit"}, description = "Лечение раненых граждан"},
        {name = "Хирург", model = "models/player/group03/male_02.mdl", salary = 650, armor = 50, weapons = {"weapon_medkit"}, description = "Проведение сложных операций"}
    },
    ["Транспорт"] = {
        {name = "Таксист", model = "models/player/eli.mdl", salary = 350, armor = 0, weapons = {}, description = "Перевозка пассажиров по городу"},
        {name = "Водитель автобуса", model = "models/player/barney.mdl", salary = 300, armor = 0, weapons = {}, description = "Общественный транспорт"},
        {name = "Дальнобойщик", model = "models/player/breen.mdl", salary = 400, armor = 0, weapons = {}, description = "Грузоперевозки на дальние расстояния"}
    },
    ["Бизнес"] = {
        {name = "Продавец", model = "models/player/group01/female_01.mdl", salary = 250, armor = 0, weapons = {}, description = "Работа в магазине"},
        {name = "Менеджер", model = "models/player/group01/male_01.mdl", salary = 500, armor = 0, weapons = {}, description = "Управление бизнесом"},
        {name = "Банкир", model = "models/player/gman_high.mdl", salary = 800, armor = 0, weapons = {}, description = "Работа в банке"}
    },
    ["Рабочие"] = {
        {name = "Шахтёр", model = "models/player/group03/male_04.mdl", salary = 300, armor = 25, weapons = {"weapon_crowbar"}, description = "Добыча ресурсов"},
        {name = "Строитель", model = "models/player/group03/male_03.mdl", salary = 350, armor = 25, weapons = {"weapon_crowbar"}, description = "Строительство зданий"},
        {name = "Электрик", model = "models/player/group03/male_05.mdl", salary = 400, armor = 25, weapons = {"weapon_tool"}, description = "Ремонт электропроводки"}
    },
    ["Другие"] = {
        {name = "Гражданин", model = "models/player/group01/female_02.mdl", salary = 200, armor = 0, weapons = {}, description = "Обычный гражданин"},
        {name = "Безработный", model = "models/player/group01/male_02.mdl", salary = 100, armor = 0, weapons = {}, description = "Поиск работы"},
        {name = "Журналист", model = "models/player/group01/female_03.mdl", salary = 350, armor = 0, weapons = {"weapon_camera"}, description = "Освещение новостей города"}
    }
}

local jobMenu = nil
local selectedCategory = 1
local selectedJob = 1

function OpenAuroraJobMenu()
    if IsValid(jobMenu) then
        jobMenu:Remove()
    end
    
    jobMenu = vgui.Create("DFrame")
    jobMenu:SetSize(900, 600)
    jobMenu:Center()
    jobMenu:SetTitle("")
    jobMenu:SetVisible(true)
    jobMenu:SetDraggable(true)
    jobMenu:ShowCloseButton(true)
    jobMenu:MakePopup()
    
    -- Custom title bar
    jobMenu.Paint = function(self, w, h)
        draw.RoundedBoxEx(15, 0, 0, w, h, Color(20, 20, 30, 240), true, true, true, true)
        
        -- Aurora gradient
        local gradient = surface.GetTextureID("gui/gradient_down")
        surface.SetTexture(gradient)
        surface.SetDrawColor(138, 43, 226, 100)
        surface.DrawTexturedRect(0, 0, w, 80)
        
        -- Title
        draw.SimpleText("AURORA RP", "DermaLarge", w/2, 20, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        draw.SimpleText("МЕНЮ ПРОФЕССИЙ", "DermaDefault", w/2, 55, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end
    
    -- Categories panel (left side)
    local categoriesPanel = vgui.Create("DPanel", jobMenu)
    categoriesPanel:SetPos(20, 90)
    categoriesPanel:SetSize(200, 490)
    categoriesPanel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(30, 30, 45, 200))
    end
    
    -- Jobs panel (right side)
    local jobsPanel = vgui.Create("DPanel", jobMenu)
    jobsPanel:SetPos(240, 90)
    jobsPanel:SetSize(640, 490)
    jobsPanel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(30, 30, 45, 200))
    end
    
    -- Category buttons
    local categoryY = 10
    for catIndex, categoryName in ipairs(table.GetKeys(jobCategories)) do
        local catButton = vgui.Create("DButton", categoriesPanel)
        catButton:SetSize(180, 40)
        catButton:SetPos(10, categoryY)
        catButton:SetText(categoryName)
        catButton:SetFont("DermaDefault")
        
        catButton.Paint = function(self, w, h)
            if selectedCategory == catIndex then
                draw.RoundedBox(8, 0, 0, w, h, Color(138, 43, 226, 200))
            else
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 70, 150))
            end
        end
        
        catButton.DoClick = function()
            selectedCategory = catIndex
            UpdateJobsList()
        end
        
        categoryY = categoryY + 50
    end
    
    -- Jobs list
    local jobList = vgui.Create("DScrollPanel", jobsPanel)
    jobList:SetSize(620, 470)
    jobList:SetPos(10, 10)
    
    function UpdateJobsList()
        jobList:Clear()
        
        local currentCategory = table.GetKeys(jobCategories)[selectedCategory]
        local jobs = jobCategories[currentCategory]
        
        local jobY = 0
        for jobIndex, job in ipairs(jobs) do
            local jobPanel = vgui.Create("DPanel", jobList)
            jobPanel:SetSize(600, 100)
            jobPanel:SetPos(10, jobY)
            
            jobPanel.Paint = function(self, w, h)
                if selectedJob == jobIndex then
                    draw.RoundedBox(8, 0, 0, w, h, Color(138, 43, 226, 150))
                else
                    draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 70, 100))
                end
            end
            
            -- Job info
            local nameLabel = vgui.Create("DLabel", jobPanel)
            nameLabel:SetPos(120, 10)
            nameLabel:SetSize(300, 25)
            nameLabel:SetText(job.name)
            nameLabel:SetFont("DermaLarge")
            nameLabel:SetTextColor(Color(255, 255, 255))
            
            local descLabel = vgui.Create("DLabel", jobPanel)
            descLabel:SetPos(120, 35)
            descLabel:SetSize(300, 20)
            descLabel:SetText(job.description)
            descLabel:SetFont("DermaDefault")
            descLabel:SetTextColor(Color(200, 200, 200))
            
            local salaryLabel = vgui.Create("DLabel", jobPanel)
            salaryLabel:SetPos(120, 60)
            salaryLabel:SetSize(200, 20)
            salaryLabel:SetText("Зарплата: " .. DarkRP.formatMoney(job.salary))
            salaryLabel:SetFont("DermaDefault")
            salaryLabel:SetTextColor(Color(50, 205, 50))
            
            local armorLabel = vgui.Create("DLabel", jobPanel)
            armorLabel:SetPos(120, 80)
            armorLabel:SetSize(200, 15)
            armorLabel:SetText("Броня: " .. job.armor)
            armorLabel:SetFont("DermaSmall")
            armorLabel:SetTextColor(Color(64, 158, 255))
            
            -- Select button
            local selectButton = vgui.Create("DButton", jobPanel)
            selectButton:SetPos(450, 30)
            selectButton:SetSize(140, 40)
            selectButton:SetText("ВЫБРАТЬ")
            selectButton:SetFont("DermaDefault")
            
            selectButton.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 205, 50, 200))
            end
            
            selectButton.DoClick = function()
                RunConsoleCommand("say", "!job " .. job.name)
                notification.AddLegacy("Вы выбрали профессию: " .. job.name, NOTIFY_GENERIC, 5)
                jobMenu:Remove()
            end
            
            jobY = jobY + 110
        end
    end
    
    UpdateJobsList()
end

-- Bind key to open job menu (F2 by default)
hook.Add("Think", "AuroraRP_JobMenuBind", function()
    if input.IsKeyDown(KEY_F2) then
        if not jobMenu or not IsValid(jobMenu) then
            OpenAuroraJobMenu()
        end
    end
end)

print("Aurora RP Jobs Menu Loaded!")
