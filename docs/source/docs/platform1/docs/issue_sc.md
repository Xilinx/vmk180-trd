<table class="sphinxhide">
 <tr>
   <td align="center"><img src="../../media/xilinx-logo.png" width="30%"/><h1>Versal Prime -VMK180 Evaluation Kit <br>Multimedia TRD Tutorial</h1>
   </td>
 </tr>
 <tr>
 <td align="center"><h1>Known Issues</h1>

 </td>
 </tr>
</table>

Known Issues
============

* The APM, CPU utilization and power graph plots result in high CPU utilization. If the plots are disabled, the CPU utilization is reduced. This can be verified by running the top command from a terminal.

* The monitor should show a blue standby screen after boot. If that is not the case, re-plug the HDMI cable and the blue standby screen should appear.

* Enabling the primary plane on the Video Mixer by default results in a bandwidth utilization of 2GB. A patch is applied to disable the mixer primary plane by default. To enable/disable the primary plane through module_param and devmem use the following commands. To render a test pattern on the display using a utility like modetest, the primary plane should be enabled.

* Enable:

```
echo Y > /sys/module/xlnx_mixer/parameters/mixer_primary_enable
```

* Disable:

```
devmem 0xa0070040 32 0x0
echo N > /sys/module/xlnx_mixer/parameters/mixer_primary_enable
```


**License**

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at
[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)


Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


