'''
Automatic Mod Builder For Minetest V1.0


by Henry Oliver (github.com/henry9836)
'''

import os
import shutil

global modname
global path
global f

def initnewmod():
    #FILTER
    global modname
    global path
    global f
    modname = modname.lower()
    modname = modname.replace(' ', '')

    path = modname + "/init.lua"
    try:
        os.mkdir(modname)
        f = open(path ,"w+")
        f.write("-- Built Using the Automatic Mod Builder For Minetest by Henry Oliver (github.com/henry9836) \r\n")
        f.close()
    except:
        try:
            os.remove(path)
            f = open(path ,"w+")
            f.write("-- Built Using the Automatic Mod Builder For Minetest by Henry Oliver (github.com/henry9836) \r\n")
            f.close()
        except:
            print("Access Denied to create files quitting...")
            quit()
    mainmenu()

def clear():
    if os.name == 'nt':
        os.system('cls')
    elif os.name == 'posix':
        os.system('clear')
    else:
        print("clearing...")
        for x in range(100):
            print("")

def addblock():
    global modname
    newblockid = ""
    extra = ""
    extramod = ""
    clear()
    print("-= Block Factory =-")
    newblockid = raw_input("Block/Node Name: ")
    newblockid = newblockid.replace(' ', '')
    newblockid = (modname + ":" + newblockid)
    desc = raw_input("Description: ")
    inp = raw_input("Single Texture or Multiple Textures [S/m]: ")
    if (inp == "m"):
        print("not in yet :P")
    else:
        try:
            os.mkdir(os.getcwd()+"/"+modname+"/media")
        except:
            print()
        pic_location = raw_input("Drag a texture in (must be: 16x16, 32x32, 64x64, 128x128, etc ONLY): ")
        tmppath = os.getcwd()+"/"+modname+"/media"
        shutil.copy(pic_location, tmppath)
        texturename = raw_input("Name of texture (with extension [e.g picture.png]): ")
        tiles = 'tiles = {"'+ texturename +'"}'

        # Extras
        inp = raw_input("Transparent? [N/y]")
        if (inp == "y"):
            inp = raw_input("[G]lass Like or [L]eaf Like? [G/l]")
            if (inp == "l"):
                extra = extra + ', drawtype = "allfaces"'
            else:
                inp = raw_input("Connect Glasslike? [Y/n]")
                if (inp == "n"):
                    extra = extra + ', drawtype = "glasslike"'
                else:
                    extra = extra + ', drawtype = "glasslike_framed"'
        inp = raw_input("Should it come up in the creative menu? [Y/n]")
        if (inp != "n"):
            block_n = raw_input("Name of new block: ")
            extra = extra + ', minetest.register_alias("' + block_n + '", "'+newblockid+'"), itemname = minetest.registered_aliases[itemname] or itemname'
        inp = raw_input("Is this an ore? [N/y]")
        if (inp == "y"):
            extra = extra + ', is_ground_content = true, groups = {cracky=3, stone=1}'
            inp = raw_input("Does it drop any items when destroyed? [Y/n]")
            if (inp != "n"):
                inp = raw_input("Name of item dropped: ")
                inp2 = raw_input("is it from [Y]our mod, [D]eafault or [O]ther mod? [Y/d/o]")
                if (inp2 == "d"):
                    extra = extra + ', drop = "default:'+ inp +'"'
                elif (inp2 == "o"):
                    inp3 = raw_input("name of other mod: ")
                    extra = extra + ', drop = "' + inp3 + ':' + inp +'"'
                else:
                    extra = extra + ', drop = "' + modname + ':' + inp +'"'
            extramod = '\r\n ' + 'minetest.register_ore({ ore_type = "scatter", ore = "'+ newblockid + '", wherein = "default:stone", clust_scarcity = 8*8*8, clust_num_ores = 8, clust_size     = 3, height_min     = -31000, height_max     = 64,})'



    #BUILD Time

    chunk = 'minetest.register_node("'+newblockid+'", { description = "' + desc + '", ' + tiles + extra + '}) \r\n' + extramod + '\r\n'
    f = open(path ,"a+")
    f.write(chunk)
    f.close()

def additem():
    global modname
    newitemid = ""
    extra = ""
    extramod = ""
    clear()
    print("-= Item Forger =-")
    newitemid = raw_input("Item Name: ")
    newitemid = newitemid.replace(' ', '')
    newitemid = (modname + ":" + newitemid)
    desc = raw_input("Description: ")
    try:
        os.mkdir(os.getcwd()+"/"+modname+"/textures")
    except:
        print()
    pic_location = raw_input("Drag a texture in (must be: 16x16, 32x32, 64x64, 128x128, etc ONLY): ")
    tmppath = os.getcwd()+"/"+modname+"/textures"
    shutil.copy(pic_location, tmppath)
    texturename = raw_input("Name of texture (with extension [e.g picture.png]): ")
    inventory_image = 'inventory_image = "'+ texturename +'"'

    #EXTRAS

    inp = raw_input("Should it come up in the creative menu? [Y/n]")
    if (inp != "n"):
        item_n = raw_input("Name of item: ")
        extra = extra + ', minetest.register_alias("' + item_n + '", "'+newitemid+'"), itemname = minetest.registered_aliases[itemname] or itemname'
    inp = raw_input("Do you want the item to print to chat when left clicked? [N/y]")
    if (inp == "y"):
        msg = raw_input("Message: ")
        extra = extra + ', on_use = function(itemstack, placer, pointed_thing) minetest.chat_send_player(placer:get_player_name(), "' + msg + '") return itemstack end'

    #Crafting
    inp = raw_input("Do you want the item to be craftable? [Y/n]")

    if (inp != "n"):
        inp10 = raw_input("Amount Outputted: ")
        inp1 = raw_input("Top-Left Slot format(modname:item): ")
        inp2 = raw_input("Top-Mid Slot format(modname:item): ")
        inp3 = raw_input("Top-Right Slot format(modname:item): ")
        inp4 = raw_input("Mid-Left Slot format(modname:item): ")
        inp5 = raw_input("Mid-Mid Slot format(modname:item): ")
        inp6 = raw_input("Mid-Right Slot format(modname:item): ")
        inp7 = raw_input("Bottom-Left Slot format(modname:item): ")
        inp8 = raw_input("Bottom-Mid Slot format(modname:item): ")
        inp9 = raw_input("Bottom-Right Slot format(modname:item): ")
        extramod = '\r\n ' + 'minetest.register_craft({ type = "shaped", output = "'+ newitemid + " " + inp10 + '", recipe = {{"'+ inp1 +'", "'+ inp2 +'", "'+ inp3 +'"},{"'+ inp4 +'", "'+ inp5 +'", "'+ inp6 +'"},{"'+ inp7 +'", "'+ inp8 +'", "'+ inp9 +'"}}})'



    #BUILD TIME

    chunk = 'minetest.register_craftitem("'+newitemid+'", { description = "' + desc + '", inventory_image = "' + texturename + '" ' + extra + '}) \r\n' + extramod + '\r\n'
    f = open(path ,"a+")
    f.write(chunk)
    f.close()

def mainmenu():
    global modname
    global path
    clear()
    print("-= Main Menu =-")
    print("Currently Working on: " + modname + ", located at: "+ os.getcwd() + "/" + path)
    print("Options")
    print("1. Add a block/node")
    print("2. Add an item")
    print("99. Exit")
    inp = raw_input("Select An Option: ")
    if (inp == "1"):
        addblock()
    elif (inp == "2"):
        additem()
    elif (inp == "99"):
        quit()
    mainmenu()

#START

print("Welcome to the Automatic Mod Builder For Minetest")
print("Verison: V1.0")
print("~Built by Henry Oliver")
print("")
inp = raw_input("Make a New Mod [Y/n]: ")
if (inp == "n"):
    modname = raw_input("Mod Name: ")
    path = modname + "/init.lua"
    try:
        f = open(path ,"a+")
        f.write("-- Built Using the Automatic Mod Builder For Minetest by Henry Oliver (github.com/henry9836) \r\n")
        f.close()
    except:
        print("Access Denied to edit files quitting...")
        quit()
    mainmenu()
else:
    modname = raw_input("Mod Name: ")
    initnewmod()
