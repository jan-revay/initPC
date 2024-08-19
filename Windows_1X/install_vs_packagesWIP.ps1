
# TODO finish

# Define the path to the Visual Studio Installer
$vsInstallerPath = "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe"

# Check if the Visual Studio Installer exists
if (-Not (Test-Path $vsInstallerPath)) {
    Write-Host "Visual Studio Installer not found at $vsInstallerPath"
    exit 1
}

# List of workloads to install (C++ development in this case)
$workloads = "Microsoft.VisualStudio.Workload.NativeDesktop"

# Optional components (modify as needed)
$components = @(
    "Microsoft.VisualStudio.Component.VC.ATL",                     # ATL support
    "Microsoft.VisualStudio.Component.VC.ATLMFC",                  # MFC support
    "Microsoft.VisualStudio.Component.VC.CLI.Support",             # C++/CLI support
    "Microsoft.VisualStudio.Component.VC.CMake.Project",           # CMake tools for Windows
    "Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset",       # LLVM Clang toolset for Windows
    "Microsoft.VisualStudio.Component.VC.Tools.x86.x64"            # MSVC v142 - VS 2019 C++ x64/x86 build tools
)

# Convert the workloads and components arrays to a string for the installer
$workloadsString = $workloads # -join ","
$componentsString = $components -join ","

# Construct the install command
$installCmd = "$vsInstallerPath modify --add $workloadsString --includeRecommended --includeOptional --addProductLang en-US"

# Add optional components if specified
if ($componentsString) {
    $installCmd += " --add $componentsString"
}

# Execute the install command
Start-Process -NoNewWindow -Wait -FilePath $vsInstallerPath -ArgumentList $installCmd

# Check if the installation was successful
if ($LASTEXITCODE -eq 0) {
    Write-Host "C++ development packages successfully installed."
} else {
    Write-Host "Failed to install C++ development packages. Exit code: $LASTEXITCODE"
}

