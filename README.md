# Dust and Smoke Detection using Multi-Channel Imagers

Alghoritms to detect the presence and concentrations of smoke and dust aerosols in the atmosphere. This is important for air quality monitoring. Multi-channel satellite imagers can be used for this purpose. 

## Methods

- Developed algorithms to detect smoke using visible and infrared channels of multi-channel satellites (GOES-R ABI).
- Separate smoke detection algorithms over land and ocean to account for differences in cloud types.
- Thresholds on brightness temperature (BT) differences used to identify smoke.

## Results

- Algorithm detects thick smoke plumes over land reasonably well. 
- More difficult to separate thin or diffuse smoke from arid land surfaces.
- Smoke over ocean also detected but appears less extensive than RGB imagery.

## Conclusion

The techniques can be applied to other multi-channel imagers like MODIS, VIIRS. For Indonesia, channel adjustments are needed for Himawari-8 compatibility.

## Future Work

- Improve detection of thin/diffuse smoke over land and ocean.
- Better distinction between smoke and low clouds over ocean.  
- Incorporate nighttime smoke detection.
- Validate with additional datasets like CALIOP lidar.

## References

Zhao et al. (2013) Dust and Smoke Detection for Multi-Channel Imagers. JTECH.

