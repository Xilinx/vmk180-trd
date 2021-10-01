echo "setting IMX274 to SRGBB 3840x2160"
xmedia-ctl -d /dev/media0 -V '"IMX274 2-001a":0 [fmt:SRGGB8_1X8/3840x2160@1/30 field:none]'
echo "setting csiss to SRGBB 3840x2160"
xmedia-ctl -d /dev/media0 -V '"a4060000.csiss":0 [fmt:SRGGB8_1X8/3840x2160 field:none]'
echo "setting demosaic:0  SRGBB 3840x2160"
xmedia-ctl -d /dev/media0 -V '"a40c0000.v_demosaic":0 [fmt:SRGGB8_1X8/3840x2160 field:none]'
echo "setting demosaic:1  RGB24 3840x2160"
xmedia-ctl -d /dev/media0 -V '"a40c0000.v_demosaic":1 [fmt:RBG24/3840x2160 field:none]'
echo "setting scalar:0  RGB24 3840x2160"
xmedia-ctl -d /dev/media0 -V '"a4080000.scaler":0 [fmt:RBG24/3840x2160 field:none]'
echo "setting scalar:1  UYVy8_1X16 3840x2160"
xmedia-ctl -d /dev/media0 -V '"a4080000.scaler":1 [fmt:UYVY8_1X16/3840x2160 field:none]'

