# Simulink Model: Takeoff Analysis

## Overview
This project compares takeoff models using three approaches: 
1. A **Physics-Based Model** of the takeoff run.  
2. An **INS-Based Model** (Inertial Navigation System) created from phone accelerometer, gyroscope, and GPS data.  
3. A **GPS-Based Model** recorded using phone GPS data.  

The project involves tuning key parameters in the physics-based model to match the INS-based model and comparing results.

---

## Key Tasks
1. **Physics-Based Model**  
   A physics-based takeoff model was built in Simulink using engine performance as a basis. Key components include:  
   - Aircraft thrust and drag modeling  
   - Rolling friction (μ)  
   - Lift calculations based on $C_{L_0}$  

2. **INS-Based Model**  
   - Built using phone-based inertial sensors (accelerometer, gyroscope, and GPS).  
   - Calculates position, velocity, and acceleration during the takeoff roll.

3. **Model Tuning**  
   The following parameters were tuned in the physics-based model to match the INS model:  
   - Oswald Efficiency Factor (e)  
   - Friction Coefficient (μ)  
   - $C_{L_0}$ (Lift Coefficient at zero AOA)  
   - Additional drag factors (f)  

4. **Results**
<div style="text-align: center;">
  
![image](https://github.com/user-attachments/assets/36c43fc8-f5c6-49a1-920f-8c81bc23f969)
*Takeoff and in-flight operations during data collection: Left - Pilots monitoring instrumentation for takeoff conditions; Right - Aerial view of Daytona Beach during flight testing.*

![image](https://github.com/user-attachments/assets/7c17bbb3-bb99-44b2-b81d-9c7656e34c6f)
*Data collection setup using GFRecorder: The image shows one of the two iPads running the GFRecorder app, positioned carefully to maintain a consistent reference frame during flight. Despite our efforts, one iPad failed to collect GPS data, while the other reported erroneous latitude values corresponding to Antarctica. Fortunately, as a backup, we used a personal cell phone running the Phyphox app, ensuring reliable data collection in line with our contingency planning.*


Using the simulink the following images can be generated. First is a lat/long map of the GPS (top) and INS (bottom) method at Deland.

![image](https://github.com/user-attachments/assets/686dddb0-6e0b-40e0-b8df-29be2dbddad5)

Then the groundspeed and distance down the runway could be calculated as seen below:
![image](https://github.com/user-attachments/assets/5d825342-4507-4c3f-9b93-35731792a6bc)

![image](https://github.com/user-attachments/assets/4d4765bc-e5ec-4d6a-9d18-1010a0a89b96)

</div>

6. **Distance to 1.2 Vso**  
   The takeoff distance required to reach 1.2 times the stall speed $V_{SO}$
 is computed.  
   - Daytona: Between **900 ft and 1200 ft**.  
   - Deland: Similar range.  

---

## Test Locations and Results
Data for the takeoff runs was recorded at the following airports:  
- **Daytona Beach Airport**: Two clean runs recorded.  
- **Deland Airport**: Additional clean run recorded.  

| Parameter             | Daytona Run | Deland Run |
|-----------------------|-------------|------------|
| Friction Coefficient (μ) | 0.1         | 0.8        |
| Distance to 1.2 Vso   | 900–1200 ft | 900–1200 ft|  

---

## Models Overview (Dropdown Sections for Details)
<details>
<summary>INS-Based Model</summary>
The INS-based model uses data from a phone app that records accelerometer, gyroscope, and GPS signals.  
- **Tools Used**: Phone sensors and data fusion.  
- **Challenges**: Outlier corrections and sensor noise management.
</details>

<details>
<summary>GPS-Based Model</summary>
The GPS-based model uses position data logged by the phone's GPS sensors.  
- **Tools Used**: Phyphox App for data logging.  
- **Challenges**: Low time resolution and occasional GPS errors.
</details>

<details>
<summary>Physics-Based Simulink Model</summary>
The Simulink model uses equations of motion for takeoff and landing with engine performance inputs.  
- Includes rolling friction, lift, drag, and thrust forces.  
- Tuning parameters include e, μ, $C_{L_0}$, and f.
</details>


---
## Files Included
```text
📦Takeoff Performance
 ┣ Takeoff_Sim.slx
 ┣ initialize.m
 ┣ 📂Data
 ┃ ┣ 📂Daytona
 ┃ ┃ ┣ 📄Accelerometer.csv
 ┃ ┃ ┣ 📄Gyroscope.csv
 ┃ ┃ ┗ 📄Location.csv
 ┃ ┣ 📂Daytona
 ┃ ┃ ┣ 📄Accelerometer_deland.csv
 ┃ ┃ ┣ 📄Gyroscope_deland.csv
 ┃ ┗ ┗ 📄Location_deland.csv
 ┗ 📄README.md
```
---

## Instructions for Running the Simulink Model
1. Open `Takeoff_Sim_my_data.slx` in MATLAB Simulink.  
2. Run `initialize.m`
3. Select "Import Data" on Matlab HOME, then select Output type as "Numeric Matrix"
4. Adjust your parameters as need
5. Run Simulink Model

