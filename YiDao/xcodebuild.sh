#引用文件
. ./test.sh

#获取info.plist文件
testApp_plist_path=./YiDao/Info.plist
#获取YDConfig.swift文件
testApp_YDConfig_path=./YiDao/Tool/YDConfig.swift

#获取APP名称
cityName=${pcode["10"]}
#echo -e ${cityName}
#更改APP名称
/usr/libexec/PlistBuddy -c "Set CFBundleDisplayName ${cityName}" ${testApp_plist_path}

cat ${testApp_YDConfig_path} | while read line;
do
resultLine=$(grep id $line)
echo "resultLine is =="${resultLine}
done


