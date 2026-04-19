-- Aurora RP - Donate Menu (F3)
-- Donation shop menu - ready for customization

if not CLIENT then return end

local donateMenu = nil
local donateMenuOpen = false

local donateItems = {
    vip = {
        {name = "VIP Basic", price = 100, description = "Basic VIP status with perks", command = "!givevip basic"},
        {name = "VIP Premium", price = 250, description = "Premium VIP with extra benefits", command = "!givevip premium"},
        {name = "VIP Elite", price = 500, description = "Elite VIP with all features", command = "!givevip elite"},
    },
    money = {
        {name = "$5,000", price = 50, description = "Get $5,000 in-game cash", command = "!givemoney 5000"},
        {name = "$25,000", price = 200, description = "Get $25,000 in-game cash", command = "!givemoney 25000"},
        {name = "$100,000", price = 700, description = "Get $100,000 in-game cash", command = "!givemoney 100000"},
    },
    weapons = {
        {name = "Weapon Pack 1", price = 150, description = "Basic weapons pack", command = "!giveweapons pack1"},
        {name = "Weapon Pack 2", price = 300, description = "Advanced weapons pack", command = "!giveweapons pack2"},
        {name = "Special Weapons", price = 500, description = "Exclusive weapons", command = "!giveweapons special"},
    },
    vehicles = {
        {name = "Sports Car", price = 400, description = "Fast sports vehicle", command = "!givevehicle sport"},
        {name = "Luxury Sedan", price = 350, description = "Comfortable luxury car", command = "!givevehicle luxury"},
        {name = "Motorcycle", price = 200, description = "Fast motorcycle", command = "!givevehicle bike"},
    },
    pets = {
        {name = "Dog Companion", price = 100, description = "Loyal dog pet", command = "!givepet dog"},
        {name = "Cat Companion", price = 80, description = "Cute cat pet", command = "!givepet cat"},
    }
}

local categoryNames = {
    vip = "VIP Status",
    money = "Money Packs",
    weapons = "Weapon Packs",
    vehicles = "Vehicles",
    pets = "Pets"
}

local categoryIcons = {
    vip = "⭐",
    money = "💰",
    weapons = "🔫",
    vehicles = "🚗",
    pets = "🐾"
}

local function createDonateMenu()
    if IsValid(donateMenu) then donateMenu:Remove() end
    
    donateMenu = vgui.Create("DFrame")
    donateMenu:SetSize(900, 650)
    donateMenu:Center()
    donateMenu:SetTitle("")
    donateMenu:SetVisible(false)
    donateMenu:SetDraggable(true)
    donateMenu:ShowCloseButton(true)
    donateMenu:MakePopup()
    
    -- Custom title bar
    donateMenu.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(20, 20, 40, 230))
        draw.RoundedBox(8, 0, 0, w, 60, Color(255, 215, 0, 200)) -- Gold color for donate
        
        draw.SimpleText("AURORA RP - DONATE SHOP", "DermaExtraLarge", w/2, 18, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        draw.SimpleText("Support the server and get exclusive items!", "DermaDefault", w/2, 45, Color(255, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end
    
    -- Category selector (left panel)
    local categoryPanel = vgui.Create("DPanel", donateMenu)
    categoryPanel:SetPos(10, 70)
    categoryPanel:SetSize(200, 570)
    categoryPanel.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(30, 30, 50, 200))
    end
    
    -- Items display (right panel)
    local itemsScroll = vgui.Create("DScrollPanel", donateMenu)
    itemsScroll:SetPos(220, 70)
    itemsScroll:SetSize(670, 570)
    itemsScroll:GetCanvas():DockPadding(10, 10, 10, 10)
    
    local selectedCategory = "vip"
    
    local function updateItemsList()
        itemsScroll:Clear()
        
        local items = donateItems[selectedCategory] or {}
        local yPos = 0
        
        for _, item in ipairs(items) do
            local itemCard = vgui.Create("DPanel", itemsScroll)
            itemCard:SetSize(640, 90)
            itemCard:SetPos(0, yPos)
            
            itemCard.Paint = function(self, w, h)
                draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 70, 200))
                draw.RoundedBox(4, 0, 0, 4, h, Color(255, 215, 0)) -- Gold accent
            end
            
            -- Item name
            local nameLabel = vgui.Create("DLabel", itemCard)
            nameLabel:SetText(categoryIcons[selectedCategory] .. " " .. item.name)
            nameLabel:SetFont("DermaLarge")
            nameLabel:SetTextColor(Color(255, 215, 0))
            nameLabel:SetPos(15, 10)
            nameLabel:SizeToContents()
            
            -- Item description
            local descLabel = vgui.Create("DLabel", itemCard)
            descLabel:SetText(item.description)
            descLabel:SetFont("DermaDefault")
            descLabel:SetTextColor(Color(200, 200, 200))
            descLabel:SetPos(15, 35)
            descLabel:SetSize(400, 30)
            
            -- Price
            local priceLabel = vgui.Create("DLabel", itemCard)
            priceLabel:SetText("$" .. item.price .. " USD")
            priceLabel:SetFont("DermaExtraLarge")
            priceLabel:SetTextColor(Color(100, 255, 100))
            priceLabel:SetPos(450, 25)
            priceLabel:SizeToContents()
            
            -- Buy button
            local buyBtn = vgui.Create("DButton", itemCard)
            buyBtn:SetText("BUY NOW")
            buyBtn:SetPos(520, 25)
            buyBtn:SetSize(110, 40)
            buyBtn:SetFont("DermaDefaultBold")
            
            buyBtn.Paint = function(self, w, h)
                draw.RoundedBox(4, 0, 0, w, h, Color(255, 215, 0))
                if self:IsHovered() then
                    draw.RoundedBox(4, 0, 0, w, h, Color(255, 235, 50))
                end
            end
            
            buyBtn.DoClick = function()
                Derma_Message("To purchase this item, please visit our store at:\n\nhttps://aurora-rp.store\n\nOr contact an administrator!", "Purchase Info", "OK")
                -- You can customize this to open a URL or execute commands
                -- gui.OpenURL("https://your-store-link.com/item/" .. item.command)
            end
            
            yPos = yPos + 100
        end
        
        itemsScroll:SetCanvasSize(650, yPos)
    end
    
    -- Category buttons
    local btnY = 10
    for catKey, catName in pairs(categoryNames) do
        local catBtn = vgui.Create("DButton", categoryPanel)
        catBtn:SetText(categoryIcons[catKey] .. " " .. catName)
        catBtn:SetPos(10, btnY)
        catBtn:SetSize(180, 50)
        catBtn:SetFont("DermaDefaultBold")
        
        catBtn.Paint = function(self, w, h)
            local color = selectedCategory == catKey and Color(255, 215, 0) or Color(50, 50, 80)
            draw.RoundedBox(4, 0, 0, w, h, color)
        end
        
        catBtn.DoClick = function()
            selectedCategory = catKey
            updateItemsList()
        end
        
        btnY = btnY + 60
    end
    
    -- Info panel at bottom
    local infoPanel = vgui.Create("DPanel", donateMenu)
    infoPanel:SetPos(220, 650)
    infoPanel:SetSize(670, 40)
    infoPanel.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(40, 40, 60, 200))
        draw.SimpleText("All purchases support server development. Thank you!", "DermaDefault", w/2, 10, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end
    
    -- Initial population
    updateItemsList()
end

-- F3 to open donate menu
hook.Add("HUDPaint", "AuroraRP_DonateMenuKey", function()
    if input.IsKeyDown(KEY_F3) and not donateMenuOpen then
        donateMenuOpen = true
        if not IsValid(donateMenu) then
            createDonateMenu()
        end
        donateMenu:SetVisible(true)
        donateMenu:MakePopup()
    end
    
    if not input.IsKeyDown(KEY_F3) then
        donateMenuOpen = false
    end
end)

print("[Aurora RP] Donate menu loaded!")
