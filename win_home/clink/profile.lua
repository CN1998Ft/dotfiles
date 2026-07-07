-- Clink profile
-- starship
load(io.popen("starship init cmd"):read("*a"))()

-- alias
os.setalias("n", "nvim $*")
os.setalias("nvide", "Neovide.exe $*")
os.setalias("ls", "eza -h --group-directories-first --icons=auto $*")
os.setalias("lua", "luajit $*")
os.setalias("open", "start $*")
os.setalias(
	"msvc",
	[["C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools\\VsDevCmd.bat" -arch=x64 -host_arch=x64 ]]
)
-- Expand ~ to %USERPROFILE%
local function tilde_expander(command_line)
	-- Check if the command starts with 'cd ' (case-insensitive)
	local cmd_str = tostring(command_line)
	if string.match(cmd_str, "^cd%s+") and string.match(cmd_str, "~") then
		-- Replace '~' with the USERPROFILE environment variable
		local user_profile = os.getenv("USERPROFILE")
		if user_profile then
			local new_command = string.gsub(command_line, "~", user_profile)
			return new_command
		end
	end
	-- Return nil if we didn't modify the command
	return nil
end
-- Register the filter with Clink
clink.oncommand(tilde_expander)

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
