-- Aurora RP - Donate Menu
-- Beautiful donation shop menu (placeholder for future items)

local donateMenu = nil
local donateCategories = {
    ["VIP Статусы"] = {
        {name = "VIP", price = 100, description = "Базовый VIP статус с привилегиями", id = "vip_basic"},
        {name = "VIP Premium", price = 250, description = "Расширенный VIP с дополнительными возможностями", id = "vip_premium"},
        {name = "VIP Elite", price = 500, description = "Максимальный VIP статус со всеми преимуществами", id = "vip_elite"}
    },
    ["Деньги"] = {
        {name = "1000$", price = 50, description = "1000 игровых долларов", id = "money_1k"},
        {name = "5000$", price = 200, description = "5000 игровых долларов", id = "money_5k"},
        {name = "10000$", price = 350, description = "10000 игровых долларов", id = "money_10k"}
    },
    ["Оружие"] = {
        {name = "Нож", price = 25, description = "Боевой нож для ближнего боя", id = "weapon_knife"},
        {name = "Пистолет", price = 75, description = "Стандартный пистолет", id = "weapon_pistol"},
        {name = "Автомат", price = 150, description = "Штурмовая винтовка", id = "weapon_rifle"}
    },
    ["Транспорт"] = {
        {name = "Спортивная машина", price = 300, description = "Быстрый спортивный автомобиль", id = "car_sport"},
        {name = "Лимузин", price = 500, description = "Роскошный лимузин", id = "car_limousine"},
        {name = "Мотоцикл", price = 150, description = "Скоростной мотоцикл", id = "vehicle_motorcycle"}
    },
    ["Домашние животные"] = {
        {name = "Собака", price = 100, description = "Верный питомец-охранник", id = "pet_dog"},
        {name = "Кот", price = 50, description = "Домашний кот", id = "pet_cat"}
    }
}

-- This will be configured by server owner later
local donateConfig = {
    enabled = true,
    currency = "RUB",
    paymentMethods = {"Qiwi", "Yandex.Money", "WebMoney", "Card"}
}

function OpenAuroraDonateMenu()
    if IsValid(donateMenu) then
        donateMenu:Remove()
    end
    
    donateMenu = vgui.Create("DFrame")
    donateMenu:SetSize(850, 650)
    donateMenu:Center()
    donateMenu:SetTitle("")
    donateMenu:SetVisible(true)
    donateMenu:SetDraggable(true)
    donateMenu:ShowCloseButton(true)
    donateMenu:MakePopup()
    
    -- Custom title bar with aurora effect
    donateMenu.Paint = function(self, w, h)
        draw.RoundedBoxEx(15, 0, 0, w, h, Color(15, 15, 25, 245), true, true, true, true)
        
        -- Aurora gradient background
        local gradient = surface.GetTextureID("gui/gradient_down")
        surface.SetTexture(gradient)
        
        -- Purple to blue gradient
        for i = 0, 100 do
            local alpha = 150 - i
            surface.SetDrawColor(138, 43, 226, alpha)
            surface.DrawRect(0, i * 0.8, w, 1)
        end
        
        -- Title
        draw.SimpleText("AURORA RP", "DermaLarge", w/2, 20, Color(138, 43, 226, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        draw.SimpleText("МАГАЗИН ПОЖЕРТВОВАНИЙ", "DermaDefault", w/2, 55, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        
        -- Info text
        draw.SimpleText("Выберите товар для покупки", "DermaSmall", w/2, 75, Color(150, 150, 150, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end
    
    -- Categories panel (left side)
    local categoriesPanel = vgui.Create("DPanel", donateMenu)
    categoriesPanel:SetPos(20, 90)
    categoriesPanel:SetSize(180, 540)
    categoriesPanel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(25, 25, 40, 220))
    end
    
    -- Items panel (right side)
    local itemsPanel = vgui.Create("DPanel", donateMenu)
    itemsPanel:SetPos(220, 90)
    itemsPanel:SetSize(610, 540)
    itemsPanel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(25, 25, 40, 220))
    end
    
    local selectedDonateCategory = 1
    local selectedDonateItem = 1
    
    -- Category buttons
    local categoryY = 10
    for catIndex, categoryName in ipairs(table.GetKeys(donateCategories)) do
        local catButton = vgui.Create("DButton", categoriesPanel)
        catButton:SetSize(160, 45)
        catButton:SetPos(10, categoryY)
        catButton:SetText(categoryName)
        catButton:SetFont("DermaDefault")
        
        catButton.Paint = function(self, w, h)
            if selectedDonateCategory == catIndex then
                draw.RoundedBox(8, 0, 0, w, h, Color(138, 43, 226, 220))
            else
                draw.RoundedBox(8, 0, 0, w, h, Color(40, 40, 60, 180))
            end
        end
        
        catButton.DoClick = function()
            selectedDonateCategory = catIndex
            UpdateDonateItemsList()
        end
        
        categoryY = categoryY + 55
    end
    
    -- Items list
    local itemList = vgui.Create("DScrollPanel", itemsPanel)
    itemList:SetSize(590, 520)
    itemList:SetPos(10, 10)
    
    function UpdateDonateItemsList()
        itemList:Clear()
        
        local currentCategory = table.GetKeys(donateCategories)[selectedDonateCategory]
        local items = donateCategories[currentCategory]
        
        local itemY = 0
        for itemIndex, item in ipairs(items) do
            local itemPanel = vgui.Create("DPanel", itemList)
            itemPanel:SetSize(570, 90)
            itemPanel:SetPos(10, itemY)
            
            itemPanel.Paint = function(self, w, h)
                if selectedDonateItem == itemIndex then
                    draw.RoundedBox(8, 0, 0, w, h, Color(138, 43, 226, 180))
                else
                    draw.RoundedBox(8, 0, 0, w, h, Color(40, 40, 60, 150))
                end
            end
            
            -- Item name
            local nameLabel = vgui.Create("DLabel", itemPanel)
            nameLabel:SetPos(15, 10)
            nameLabel:SetSize(300, 25)
            nameLabel:SetText(item.name)
            nameLabel:SetFont("DermaLarge")
            nameLabel:SetTextColor(Color(255, 255, 255))
            
            -- Item description
            local descLabel = vgui.Create("DLabel", itemPanel)
            descLabel:SetPos(15, 35)
            descLabel:SetSize(350, 20)
            descLabel:SetText(item.description)
            descLabel:SetFont("DermaDefault")
            descLabel:SetTextColor(Color(200, 200, 200))
            
            -- Price
            local priceLabel = vgui.Create("DLabel", itemPanel)
            priceLabel:SetPos(15, 60)
            priceLabel:SetSize(200, 20)
            priceLabel:SetText("Цена: " .. item.price .. " " .. donateConfig.currency)
            priceLabel:SetFont("DermaDefault")
            priceLabel:SetTextColor(Color(50, 205, 50))
            
            -- Buy button
            local buyButton = vgui.Create("DButton", itemPanel)
            buyButton:SetPos(420, 25)
            buyButton:SetSize(140, 40)
            buyButton:SetText("КУПИТЬ")
            buyButton:SetFont("DermaDefault")
            
            buyButton.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 205, 50, 220))
            end
            
            buyButton.DoClick = function()
                -- Placeholder for purchase logic
                Derma_Message("Для покупки обратитесь к администратору сервера или используйте команду:\n/donate " .. item.id, "Aurora RP Магазин", "OK")
                
                -- Send purchase request to server
                RunConsoleCommand("say", "!donate " .. item.id)
                notification.AddLegacy("Запрос на покупку: " .. item.name, NOTIFY_GENERIC, 5)
            end
            
            itemY = itemY + 100
        end
    end
    
    UpdateDonateItemsList()
    
    -- Payment methods info at bottom
    local paymentInfo = vgui.Create("DLabel", donateMenu)
    paymentInfo:SetPos(220, 635)
    paymentInfo:SetSize(610, 20)
    paymentInfo:SetText("Доступные способы оплаты: " .. table.concat(donateConfig.paymentMethods, ", "))
    paymentInfo:SetFont("DermaSmall")
    paymentInfo:SetTextColor(Color(150, 150, 150))
end

-- Bind key to open donate menu (F3 by default)
hook.Add("Think", "AuroraRP_DonateMenuBind", function()
    if input.IsKeyDown(KEY_F3) then
        if not donateMenu or not IsValid(donateMenu) then
            OpenAuroraDonateMenu()
        end
    end
end)

print("Aurora RP Donate Menu Loaded!")
