find . -name "*.cs" -not -path "*AssemblyInfo.cs" -not -path "*/obj/*" -not -path "*/bin/*" | xargs wc -l
read -n 1 -s -r -p "Press any key to exit"