with open("inputDay7.txt", "r") as f:
    lines = f.read().split("\n")[:-1]

def makeFullPath(currentDir, parents):
    return '/'.join(parents + [currentDir])

storage = {}

parentDirs = []
currentDir = None
for line in lines:
    if line.startswith('$'):
        if line.find('cd') != -1:
            argument = line[5:]
            if argument == '..':
                currentDir = parentDirs.pop()
            else:
                if currentDir:
                    parentDirs.append(currentDir)
                currentDir = argument
                if currentDir not in storage:
                    storage[makeFullPath(currentDir, parentDirs)] = 0
    else:
        if not line.startswith('dir'):
            size, _ = line.split(' ')
            storage[makeFullPath(currentDir, parentDirs)] += int(size)

            for index, parent in enumerate(parentDirs):
                storage[makeFullPath(parent, parentDirs[:index])] += int(size)

print("Part 1", sum([storage[x] if storage[x] <= 100_000 else 0 for x in storage]))

print(storage["/"])

folderToDelete = '/'
freeUp = 30_000_000 - (70_000_000 - (storage[folderToDelete]))
for folder in storage:
    if storage[folder] > freeUp and storage[folder] < storage[folderToDelete]:
        folderToDelete = folder

print("Part 2", storage[folderToDelete])