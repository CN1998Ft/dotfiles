-- Clink profile
-- starship
load(io.popen("starship init cmd"):read("*a"))()

-- alias
os.setalias("n", "nvim $*")
os.setalias("nvide", "Neovide.exe $*")
os.setalias("ls", "eza -h --group-directories-first --icons=auto $*")
os.setalias("lua", "luajit $*")
os.setalias("open", "start $*")
os.setalias("drawio", "draw.io $*")
os.setalias(
	"msvc",
	[["C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools\\VsDevCmd.bat" -arch=x64 -host_arch=x64 ]]
)

-- borrow git usr stuff for windows usage
local git_usr_bin = os.getenv("USERPROFILE") .. "\\scoop\\apps\\git\\current\\usr\\bin"
os.setalias("touch", git_usr_bin .. "\\touch.exe $*")
os.setalias("ldd", git_usr_bin .. "\\ldd.exe $*")
os.setalias("less", git_usr_bin .. "\\less.exe $*")
os.setenv("PAGER", git_usr_bin .. "\\less.exe")
