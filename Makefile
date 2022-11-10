# Base functions and arguments of the makefile
# Functions:
# init:
# 	Download the base vagrant box and build the docker image
# build:
# 	Build the output deb and exe files based on the repository and branch
# 	Uses two variables as arguments:
#		version: Version of the build Semantic Versioning (Used on file naming)
#		repo: The repository to be built
#		branch: Optinal argument defining the branch, defaults to master
#	The results are outputted to output/<project>/<version>/
#		The results are zipped and a checksum 256 file is created

project_name = $(shell echo $(repo) | cut -d'/' -f5 | cut -d'.' -f1)
current_dir = $(shell pwd)
windows_out_dir = $(current_dir)/windows/vagrant
linux_out_dir = $(current_dir)/linux
linux_file_name = $(project_name)-$(version)-linux
windows_file_name = $(project_name)-$(version)-windows
checksum_file_name = $(project_name)-$(version)-sha256sum
final_output_dir = $(current_dir)/output/$(project_name)/$(version)

branch ?= master

# Initialize both docker image and Vagrant box
init:
	# Build the docker image for vagrant
	docker build $(linux_out_dir) -t epic-linux-release

	# Download the windows epic cash box
	vagrant box add Jhelison/windows-epic-cash

# Build the deb and exe files
# This is the main entrypoint to build the projects
# Must be executed as: make build version=<version_of_the_build> repo=<repository_of_the_build>
# Ex: make build version=3.0.0 repo=https://github.com/EpicCash/epic.git
build:
	$(MAKE) build-windows
	$(MAKE) build-linux
	$(MAKE) build-sha256sum

# Build the windows release and them copy the files
build-windows:
	mkdir -p $(final_output_dir)

	$(MAKE) windows-entrypoint-init

	cd $(windows_out_dir) && \
	vagrant up --no-provision && \
	vagrant provision && \
	vagrant suspend

	# Move and zip the output
	mv $(windows_out_dir)/*.exe $(final_output_dir)/$(windows_file_name).exe
	zip -j -rm $(final_output_dir)/$(windows_file_name).zip $(final_output_dir)/$(windows_file_name).exe

# Build the linux release and them copy the files
build-linux:
	mkdir -p $(final_output_dir)
	docker run -v $(current_dir)/linux:/home/app/output epic-linux-release $(repo) $(branch)

	# Move and zip the output
	mv $(linux_out_dir)/*.deb $(final_output_dir)/$(linux_file_name).deb
	zip -j -rm $(final_output_dir)/$(linux_file_name).zip $(final_output_dir)/$(linux_file_name).deb

# Modify the windows and linux entrypoints to use the variables
windows-entrypoint-init:
	yes | cp -rf $(windows_out_dir)/scripts/windows-entrypoint.bat.example $(windows_out_dir)/scripts/windows-entrypoint.bat
	sed -i 's,bash_repo,${repo},' $(windows_out_dir)/scripts/windows-entrypoint.bat
	sed -i 's,bash_branch,${branch},' $(windows_out_dir)/scripts/windows-entrypoint.bat
	sed -i 's,bash_project,${project_name},' $(windows_out_dir)/scripts/windows-entrypoint.bat

# Build the sha256sum
build-sha256sum:
	sha256sum $(final_output_dir)/* > $(final_output_dir)/$(checksum_file_name).txt
	sed -i 's,$(final_output_dir)/,,' $(final_output_dir)/$(checksum_file_name).txt
