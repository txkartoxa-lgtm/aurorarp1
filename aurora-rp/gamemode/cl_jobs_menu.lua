-- Aurora RP - Jobs Menu (F2)
-- Beautiful profession selection menu

if CLIENT then
    local jobsMenu = nil
    local jobsOpen = false

    -- Create the jobs menu
    local function CreateJobsMenu()
        if IsValid(jobsMenu) then jobsMenu:Remove() end

        jobsMenu = vgui.Create("DFrame")
        jobsMenu:SetSize(800, 600)
        jobsMenu:Center()
        jobsMenu:SetTitle("AURORA RP - Выбор профессии")
        jobsMenu:SetVisible(false)
        jobsMenu:SetDraggable(true)
        jobsMenu:ShowCloseButton(true)
        jobsMenu:MakePopup()

        -- Custom title bar with gradient
        jobsMenu.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(20, 20, 40, 250))
            
            -- Title gradient
            local gradient = surface.GetTextureID("vgui/gradient-lr")
            surface.SetTexture(gradient)
            surface.SetDrawColor(138, 43, 226, 200)
            surface.DrawTexturedRect(0, 0, w, 30)
            
            draw.SimpleText("AURORA RP", "DermaLarge", w/2, 5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        end

        -- Category list on the left
        local categoryList = vgui.Create("DListView", jobsMenu)
        categoryList:SetPos(10, 40)
        categoryList:SetSize(200, 550)
        categoryList:SetMultiSelect(false)
        categoryList:AddColumn("Категория")

        local categories = {
            "Службы порядка",
            "Медицина",
            "Транспорт",
            "Бизнес",
            "Рабочие",
            "Другие"
        }

        for _, cat in ipairs(categories) do
            categoryList:AddLine(cat)
        end

        -- Jobs panel on the right
        local jobsPanel = vgui.Create("DScrollPanel", jobsMenu)
        jobsPanel:SetPos(220, 40)
        jobsPanel:SetSize(570, 550)

        -- Store job buttons for updating
        local jobButtons = {}

        -- Function to update jobs display
        local function UpdateJobsDisplay(categoryName)
            -- Clear existing buttons
            for _, btn in ipairs(jobButtons) do
                if IsValid(btn) then btn:Remove() end
            end
            jobButtons = {}

            -- Get all jobs from DarkRP
            local allJobs = DarkRP.getJobs()
            local filteredJobs = {}

            for cmd, job in pairs(allJobs) do
                if job.category == categoryName then
                    table.insert(filteredJobs, job)
                end
            end

            -- Sort jobs by salary
            table.sort(filteredJobs, function(a, b)
                return a.salary > b.salary
            end)

            -- Create job cards
            local yPos = 0
            for _, job in ipairs(filteredJobs) do
                local jobCard = vgui.Create("DPanel", jobsPanel)
                jobCard:SetPos(0, yPos)
                jobCard:SetSize(550, 100)
                
                jobCard.Paint = function(self, w, h)
                    draw.RoundedBox(5, 0, 0, w, h, Color(40, 40, 60, 200))
                    
                    -- Job name
                    draw.SimpleText(job.name, "DermaDefaultBold", 10, 10, job.color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    
                    -- Salary
                    draw.SimpleText("Зарплата: $" .. job.salary, "DermaDefault", 10, 35, Color(100, 255, 100), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    
                    -- Max players
                    draw.SimpleText("Максимум: " .. job.max, "DermaDefault", 10, 55, Color(200, 200, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    
                    -- Description
                    draw.SimpleText(job.description, "DermaDefault", 10, 75, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end

                -- Set job button
                local setJobBtn = vgui.Create("DButton", jobCard)
                setJobBtn:SetPos(450, 35)
                setJobBtn:SetSize(90, 30)
                setJobBtn:SetText("Выбрать")
                setJobBtn:SetFont("DermaDefault")
                
                setJobBtn.Paint = function(self, w, h)
                    if self:IsHovered() then
                        draw.RoundedBox(4, 0, 0, w, h, Color(138, 43, 226, 255))
                    else
                        draw.RoundedBox(4, 0, 0, w, h, Color(100, 100, 150, 200))
                    end
                end
                
                setJobBtn.DoClick = function()
                    RunConsoleCommand("job", job.command)
                    jobsMenu:Close()
                end

                table.insert(jobButtons, jobCard)
                yPos = yPos + 110
            end

            jobsPanel:SetCanvasSize(550, yPos)
        end

        -- Initial display
        if #categories > 0 then
            UpdateJobsDisplay(categories[1])
        end

        -- Category selection
        categoryList.OnRowSelected = function(lst, rowIndex, row)
            local categoryName = row:GetValue(1)
            UpdateJobsDisplay(categoryName)
        end

        return jobsMenu
    end

    -- Toggle menu with F2
    hook.Add("HUDPaint", "AuroraRP_JobsMenuKey", function()
        -- Key check is done in Think hook instead
    end)

    hook.Add("Think", "AuroraRP_JobsMenuToggle", function()
        if input.IsKeyDown(KEY_F2) and not jobsOpen then
            jobsOpen = true
            
            if not IsValid(jobsMenu) then
                jobsMenu = CreateJobsMenu()
            end
            
            jobsMenu:SetVisible(true)
            jobsMenu:MakePopup()
        end
        
        if not input.IsKeyDown(KEY_F2) then
            jobsOpen = false
        end
    end)

    print("[Aurora RP] Jobs menu loaded!")
end
