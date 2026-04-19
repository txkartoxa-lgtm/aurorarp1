-- Aurora RP - Donate Menu (F3)
-- Beautiful donation shop menu

if CLIENT then
    local donateMenu = nil
    local donateOpen = false

    -- Create the donate menu
    local function CreateDonateMenu()
        if IsValid(donateMenu) then donateMenu:Remove() end

        donateMenu = vgui.Create("DFrame")
        donateMenu:SetSize(900, 650)
        donateMenu:Center()
        donateMenu:SetTitle("AURORA RP - Донат магазин")
        donateMenu:SetVisible(false)
        donateMenu:SetDraggable(true)
        donateMenu:ShowCloseButton(true)
        donateMenu:MakePopup()

        -- Custom title bar with gradient
        donateMenu.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(20, 20, 40, 250))
            
            -- Title gradient
            local gradient = surface.GetTextureID("vgui/gradient-lr")
            surface.SetTexture(gradient)
            surface.SetDrawColor(138, 43, 226, 200)
            surface.DrawTexturedRect(0, 0, w, 30)
            
            draw.SimpleText("AURORA RP", "DermaLarge", w/2, 5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        end

        -- Category list on the left
        local categoryList = vgui.Create("DListView", donateMenu)
        categoryList:SetPos(10, 40)
        categoryList:SetSize(200, 600)
        categoryList:SetMultiSelect(false)
        categoryList:AddColumn("Категория")

        local categories = {
            "VIP статусы",
            "Деньги",
            "Оружие",
            "Транспорт",
            "Питомцы",
            "Разное"
        }

        for _, cat in ipairs(categories) do
            categoryList:AddLine(cat)
        end

        -- Items panel on the right
        local itemsPanel = vgui.Create("DScrollPanel", donateMenu)
        itemsPanel:SetPos(220, 40)
        itemsPanel:SetSize(670, 600)

        -- Store item cards for updating
        local itemCards = {}

        -- Sample donate items (you can customize these)
        local donateItems = {
            ["VIP статусы"] = {
                {name = "VIP Basic", price = 100, desc = "Базовый VIP статус с привилегиями"},
                {name = "VIP Premium", price = 250, desc = "Расширенный VIP статус"},
                {name = "VIP Elite", price = 500, desc = "Максимальный VIP статус со всеми возможностями"}
            },
            ["Деньги"] = {
                {name = "1000$", price = 50, desc = "1000 игровых долларов"},
                {name = "5000$", price = 200, desc = "5000 игровых долларов"},
                {name = "10000$", price = 350, desc = "10000 игровых долларов"}
            },
            ["Оружие"] = {
                {name = "Набор оружия 1", price = 150, desc = "Пистолет и дробовик"},
                {name = "Набор оружия 2", price = 300, desc = "Автомат и снайперская винтовка"}
            },
            ["Транспорт"] = {name = {name = "Спортивный автомобиль", price = 400, desc = "Быстрый спорткар"}},
            ["Питомцы"] = {name = {name = "Собака-охранник", price = 200, desc = "Верный охранник"}},
            ["Разное"] = {name = {name = "Ключи от всех дверей", price = 100, desc = "Доступ ко всем дверям"}}
        }

        -- Function to update items display
        local function UpdateItemsDisplay(categoryName)
            -- Clear existing cards
            for _, card in ipairs(itemCards) do
                if IsValid(card) then card:Remove() end
            end
            itemCards = {}

            local items = donateItems[categoryName] or {}

            -- Create item cards
            local yPos = 0
            for _, item in ipairs(items) do
                local itemCard = vgui.Create("DPanel", itemsPanel)
                itemCard:SetPos(0, yPos)
                itemCard:SetSize(650, 100)
                
                itemCard.Paint = function(self, w, h)
                    draw.RoundedBox(5, 0, 0, w, h, Color(40, 40, 60, 200))
                    
                    -- Item name
                    draw.SimpleText(item.name, "DermaDefaultBold", 10, 10, Color(138, 43, 226), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    
                    -- Price
                    draw.SimpleText("Цена: " .. item.price .. " руб.", "DermaDefault", 10, 35, Color(255, 215, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    
                    -- Description
                    draw.SimpleText(item.desc, "DermaDefault", 10, 55, Color(200, 200, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end

                -- Buy button
                local buyBtn = vgui.Create("DButton", itemCard)
                buyBtn:SetPos(540, 35)
                buyBtn:SetSize(100, 30)
                buyBtn:SetText("Купить")
                buyBtn:SetFont("DermaDefault")
                
                buyBtn.Paint = function(self, w, h)
                    if self:IsHovered() then
                        draw.RoundedBox(4, 0, 0, w, h, Color(100, 255, 100, 255))
                    else
                        draw.RoundedBox(4, 0, 0, w, h, Color(50, 150, 50, 200))
                    end
                end
                
                buyBtn.DoClick = function()
                    Derma_Message("Для покупки обратитесь к администратору сервера или используйте команду !donate", "Aurora RP", "OK")
                end

                table.insert(itemCards, itemCard)
                yPos = yPos + 110
            end

            itemsPanel:SetCanvasSize(650, yPos)
        end

        -- Initial display
        if #categories > 0 then
            UpdateItemsDisplay(categories[1])
        end

        -- Category selection
        categoryList.OnRowSelected = function(lst, rowIndex, row)
            local categoryName = row:GetValue(1)
            UpdateItemsDisplay(categoryName)
        end

        return donateMenu
    end

    -- Toggle menu with F3
    hook.Add("Think", "AuroraRP_DonateMenuToggle", function()
        if input.IsKeyDown(KEY_F3) and not donateOpen then
            donateOpen = true
            
            if not IsValid(donateMenu) then
                donateMenu = CreateDonateMenu()
            end
            
            donateMenu:SetVisible(true)
            donateMenu:MakePopup()
        end
        
        if not input.IsKeyDown(KEY_F3) then
            donateOpen = false
        end
    end)

    print("[Aurora RP] Donate menu loaded!")
end
