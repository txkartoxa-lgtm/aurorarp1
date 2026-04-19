-- Aurora RP - Jobs Menu (F2)
-- Beautiful profession selection menu

if not CLIENT then return end

local jobsMenu = nil
local jobsMenuOpen = false

local categories = {
    "Law Enforcement",
    "Medical",
    "Emergency",
    "Services",
    "Special"
}

local categoryColors = {
    ["Law Enforcement"] = Color(50, 50, 200),
    ["Medical"] = Color(200, 50, 50),
    ["Emergency"] = Color(200, 100, 0),
    ["Services"] = Color(0, 150, 0),
    ["Special"] = Color(100, 100, 100)
}

local function createJobsMenu()
    if IsValid(jobsMenu) then jobsMenu:Remove() end
    
    jobsMenu = vgui.Create("DFrame")
    jobsMenu:SetSize(800, 600)
    jobsMenu:Center()
    jobsMenu:SetTitle("")
    jobsMenu:SetVisible(false)
    jobsMenu:SetDraggable(true)
    jobsMenu:ShowCloseButton(true)
    jobsMenu:MakePopup()
    
    -- Custom title bar
    jobsMenu.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(20, 20, 40, 230))
        draw.RoundedBox(8, 0, 0, w, 50, Color(138, 43, 226, 200))
        
        draw.SimpleText("AURORA RP - PROFESSIONS", "DermaExtraLarge", w/2, 15, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        draw.SimpleText("Choose your role in the city", "DermaDefault", w/2, 40, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end
    
    -- Category selector
    local categoryPanel = vgui.Create("DPanel", jobsMenu)
    categoryPanel:SetPos(10, 60)
    categoryPanel:SetSize(180, 530)
    categoryPanel.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(30, 30, 50, 200))
    end
    
    local scrollPanel = vgui.Create("DScrollPanel", jobsMenu)
    scrollPanel:SetPos(200, 60)
    scrollPanel:SetSize(590, 530)
    scrollPanel:GetCanvas():DockPadding(10, 10, 10, 10)
    
    local selectedCategory = "All"
    
    local function updateJobsList()
        scrollPanel:Clear()
        
        local jobs = {}
        for _, job in ipairs(DarkRP.getJobs()) do
            if selectedCategory == "All" or job.category == selectedCategory then
                table.insert(jobs, job)
            end
        end
        
        local yPos = 0
        for _, job in ipairs(jobs) do
            local jobCard = vgui.Create("DPanel", scrollPanel)
            jobCard:SetSize(560, 100)
            jobCard:SetPos(0, yPos)
            
            local catColor = categoryColors[job.category] or Color(100, 100, 100)
            
            jobCard.Paint = function(self, w, h)
                draw.RoundedBox(4, 0, 0, w, h, Color(40, 40, 60, 200))
                draw.RoundedBox(4, 0, 0, 5, h, catColor)
            end
            
            -- Job name
            local nameLabel = vgui.Create("DLabel", jobCard)
            nameLabel:SetText(job.name)
            nameLabel:SetFont("DermaLarge")
            nameLabel:SetTextColor(catColor)
            nameLabel:SetPos(10, 10)
            nameLabel:SizeToContents()
            
            -- Job description
            local descLabel = vgui.Create("DLabel", jobCard)
            descLabel:SetText(job.description)
            descLabel:SetFont("DermaDefault")
            descLabel:SetTextColor(Color(200, 200, 200))
            descLabel:SetPos(10, 35)
            descLabel:SetSize(400, 40)
            descLabel:SetWrap(true)
            
            -- Salary
            local salaryLabel = vgui.Create("DLabel", jobCard)
            salaryLabel:SetText("Salary: $" .. (job.salary or 0) .. "/hour")
            salaryLabel:SetFont("DermaDefaultBold")
            salaryLabel:SetTextColor(Color(100, 255, 100))
            salaryLabel:SetPos(10, 70)
            salaryLabel:SizeToContents()
            
            -- Join button
            local joinBtn = vgui.Create("DButton", jobCard)
            joinBtn:SetText("JOIN")
            joinBtn:SetPos(450, 30)
            joinBtn:SetSize(100, 40)
            joinBtn:SetFont("DermaDefaultBold")
            
            joinBtn.Paint = function(self, w, h)
                draw.RoundedBox(4, 0, 0, w, h, catColor)
                if self:IsHovered() then
                    draw.RoundedBox(4, 0, 0, w, h, Color(catColor.r + 30, catColor.g + 30, catColor.b + 30))
                end
            end
            
            joinBtn.DoClick = function()
                RunCommand("say /job " .. job.command)
                jobsMenu:Close()
            end
            
            yPos = yPos + 110
        end
        
        scrollPanel:SetCanvasSize(570, yPos)
    end
    
    -- Category buttons
    local btnY = 10
    local allBtn = vgui.Create("DButton", categoryPanel)
    allBtn:SetText("All Jobs")
    allBtn:SetPos(10, btnY)
    allBtn:SetSize(160, 40)
    allBtn:SetFont("DermaDefaultBold")
    allBtn.Paint = function(self, w, h)
        local color = selectedCategory == "All" and Color(138, 43, 226) or Color(50, 50, 80)
        draw.RoundedBox(4, 0, 0, w, h, color)
    end
    allBtn.DoClick = function()
        selectedCategory = "All"
        updateJobsList()
    end
    btnY = btnY + 50
    
    for _, cat in ipairs(categories) do
        local catBtn = vgui.Create("DButton", categoryPanel)
        catBtn:SetText(cat)
        catBtn:SetPos(10, btnY)
        catBtn:SetSize(160, 40)
        catBtn:SetFont("DermaDefaultBold")
        
        local catColor = categoryColors[cat] or Color(100, 100, 100)
        catBtn.Paint = function(self, w, h)
            local color = selectedCategory == cat and catColor or Color(50, 50, 80)
            draw.RoundedBox(4, 0, 0, w, h, color)
        end
        
        catBtn.DoClick = function()
            selectedCategory = cat
            updateJobsList()
        end
        
        btnY = btnY + 50
    end
    
    -- Initial population
    updateJobsList()
end

-- F2 to open jobs menu
hook.Add("HUDPaint", "AuroraRP_JobsMenuKey", function()
    if input.IsKeyDown(KEY_F2) and not jobsMenuOpen then
        jobsMenuOpen = true
        if not IsValid(jobsMenu) then
            createJobsMenu()
        end
        jobsMenu:SetVisible(true)
        jobsMenu:MakePopup()
    end
    
    if not input.IsKeyDown(KEY_F2) then
        jobsMenuOpen = false
    end
end)

print("[Aurora RP] Jobs menu loaded!")
