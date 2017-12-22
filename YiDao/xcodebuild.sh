#引用文件
. ./test.sh

#获取info.plist文件
testApp_plist_path=./YiDao/Info.plist
#获取YDConfig.swift文件
testApp_APPSetting_path=./YiDao/configuration/APPSetting.plist

#获取APP名称
cityName=${pcode["10"]}
#echo -e ${cityName}
#更改APP名称
/usr/libexec/PlistBuddy -c "Set CFBundleDisplayName ${cityName}" ${testApp_plist_path}

#获取颜色
MainColorString=${pcode["MainColorString"]}
#echo -e ${cityName}
#更改颜色
/usr/libexec/PlistBuddy -c "Set MainColorString ${MainColorString}" ${testApp_APPSetting_path}


