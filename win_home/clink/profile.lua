-- Clink profile
-- starship
load(io.popen("starship init cmd"):read("*a"))()

-- alias
os.setalias("n", "nvim $*")
os.setalias("nvide", "Neovide.exe $*")
os.setalias("ls", "eza -h --group-directories-first --icons=auto $*")
os.setalias("lua", "luajit $*")
os.setalias("open", "start $*")
-- this cd will ruin normal cd use z instead
-- os.setalias("cd", 'for /f "delims=" %i in (\'zoxide query $*\') do @cd /d "%i"')

-- borrow git usr stuff for windows usage
local git_usr_bin = os.getenv("USERPROFILE") .. "\\scoop\\apps\\git\\current\\usr\\bin"
os.setalias("touch", git_usr_bin .. "\\touch.exe $*")
os.setalias("ldd", git_usr_bin .. "\\ldd.exe $*")
os.setalias("less", git_usr_bin .. "\\less.exe $*")
os.setenv("PAGER", git_usr_bin .. "\\less.exe")

-->> PhD python
os.setalias("pwe", 'for /f "delims=" %i in (\'zoxide query project\') do @cd /d "%i" && mamba activate phd')
os.setalias("mwe", 'for /f "delims=" %i in (\'zoxide query motion\') do @cd /d "%i" && mamba activate phd')
local pythonpath = os.getenv("PYTHONPATH")
local motion_path_dir = ""
if os.getenv("USERNAME") == "mn19fz" then
	motion_path_dir = os.getenv("USERPROFILE")--[[:gsub("\\", "\\\\")]] .. "\\Documents\\PhD\\motion_path"
elseif os.getenv("USERNAME") == "93581" then
	motion_path_dir = "D:\\PhD\\motion_path"
end
os.setenv("PYTHONPATH", pythonpath .. ";" .. motion_path_dir)
-->> PhD python
