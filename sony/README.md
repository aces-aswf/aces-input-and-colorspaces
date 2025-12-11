## IDTs for S-Log3 and S-Gamut3 / S-Gamut3.Cine
The following unified IDTs are recommended for use with all Sony cameras that support S-Log3 and S-Gamut3 / S-Gamut3.Cine, including both VENICE and VENICE 2:

- `CSC.Sony.SLog3_SGamut3_to_ACES.ctl` (S-Gamut3)
- `CSC.Sony.SLog3_SGamut3Cine_to_ACES.ctl` (S-Gamut3.Cine)

These unified IDTs are derived from theoretical values and are the recommended trasnforms for all current S-Log3 workflows.

--------------------------------------------------------
## Notes 

### VENICE-specific IDTs for original VENICE and VENICE 2 (6K)
The following transforms were created using measurements taken from VENICE cameras at the AMPAS Esmeralda facility in 2018:

- `CSC.Sony.Venice.SLog3_SGamut3_to_ACES.ctl` (S-Gamut3)
- `CSC.Sony.Venice.SLog3_SGamut3Cine_to_ACES.ctl` (S-Gamut3.Cine)

These VENICE-specific IDTs remain valid for images from the original VENICE and VENICE 2 (6K), which share the same image sensor. 

However, **there is vertually no difference between these and the unified transforms**, and technical evaluation confirms that both sets comply with ACES IDT specifications. 

For consistency and simplicity, the unified IDTs are recommended even with the original VENICE and VENICE 2 (6K).

### Archived transforms
Reference CTL files for the VENICE-specific transforms, as well as the older S-Log1 and S-Log2 IDTs, can be found in the [Sony folder of the archive directory](../archive/sony/).