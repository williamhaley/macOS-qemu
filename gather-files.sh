#!/usr/bin/env bash

set -e

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

tmp_dir=$(mktemp -d)

pushd $tmp_dir

curl -L -O https://github.com/acidanthera/OpenCorePkg/releases/download/0.7.7/OpenCore-0.7.7-DEBUG.zip
curl -L -O https://github.com/acidanthera/Lilu/releases/download/1.5.9/Lilu-1.5.9-DEBUG.zip
curl -L -O https://github.com/acidanthera/WhateverGreen/releases/download/1.5.6/WhateverGreen-1.5.6-DEBUG.zip
curl -L -O https://github.com/acidanthera/AppleALC/releases/download/1.6.8/AppleALC-1.6.8-DEBUG.zip
curl -L -O https://github.com/acidanthera/bugtracker/files/3703498/AppleMCEReporterDisabler.kext.zip
curl -L -O https://github.com/acidanthera/VirtualSMC/releases/download/1.2.8/VirtualSMC-1.2.8-DEBUG.zip
curl -L -O https://github.com/OpenIntelWireless/itlwm/releases/download/v2.1.0/itlwm_v2.1.0_stable.kext.zip

curl -L -O https://github.com/OpenIntelWireless/HeliPort/releases/download/v1.4.1/HeliPort.dmg

unzip OpenCore-0.7.7-DEBUG.zip
unzip Lilu-1.5.9-DEBUG.zip
unzip WhateverGreen-1.5.6-DEBUG.zip
unzip AppleALC-1.6.8-DEBUG.zip
unzip AppleMCEReporterDisabler.kext.zip
unzip VirtualSMC-1.2.8-DEBUG.zip
unzip itlwm_v2.1.0_stable.kext.zip

pushd ${script_dir}

mkdir -p EFI
rsync -avr $tmp_dir/X64/EFI/ ./EFI/
rsync -avr $tmp_dir/Lilu.kext/ ./EFI/OC/Kexts/Lilu.kext/
rsync -avr $tmp_dir/WhateverGreen.kext/ ./EFI/OC/Kexts/WhateverGreen.kext/
rsync -avr $tmp_dir/AppleALC.kext/ ./EFI/OC/Kexts/AppleALC.kext/
rsync -avr $tmp_dir/AppleMCEReporterDisabler.kext/ ./EFI/OC/Kexts/AppleMCEReporterDisabler.kext/
rsync -avr $tmp_dir/Kexts/VirtualSMC.kext/ ./EFI/OC/Kexts/VirtualSMC.kext/
rsync -avr $tmp_dir/itlwm.kext/ ./EFI/OC/Kexts/itlwm.kext/

mkdir -p ./EFI/Apps
cp $tmp_dir/HeliPort.dmg ./EFI/Apps/HeliPort.dmg

rm -rf $tmp_dir
