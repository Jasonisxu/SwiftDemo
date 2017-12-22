#引用文件
. ./test.sh

#获取info.plist文件
testApp_plist_path=./YiDao/Info.plist
#获取YDConfig.swift文件
testApp_APPSetting_path=./YiDao/configuration/APPSetting.plist
#获取project.pbxproj文件
testApp_project_path=./YiDao.xcodeproj/project.pbxproj

#获取APP名称
cityName=${pcode["22"]}
#echo -e ${cityName}
#更改APP名称
/usr/libexec/PlistBuddy -c "Set CFBundleDisplayName ${cityName}" ${testApp_plist_path}

##更改APP版本号
#/usr/libexec/PlistBuddy -c "Set CFBundleShortVersionString ${cityName}" ${testApp_plist_path}

## 新老BundleId
#oldBundleId="com.wicrenet.wiseSellerTest"
#newBundleId="com.hs.rest1"
## 修改bundle identifier
#sed -i '' s/${oldBundleId}/${newBundleId}/g ${testApp_project_path}


#获取颜色
MainColorString=${pcode["MainColorString"]}
#echo -e ${cityName}
#更改颜色
/usr/libexec/PlistBuddy -c "Set MainColorString ${MainColorString}" ${testApp_APPSetting_path}


#执行脚本
base xcodebuild.sh
