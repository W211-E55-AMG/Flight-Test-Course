## Data Format Documentation

### Overview
This README explains the structure and purpose of three datasets used in the project: **Accelerometer Data**, **Gyroscope Data**, and **Location Data**. Each dataset is stored in a separate CSV file and contains time-aligned sensor measurements collected during flight tests.

---

### 1. Accelerometer Data
**File Name**: `Accelerometer.csv`  

| **Column Name**        | **Description**                                     | **Unit**          |
|------------------------|-----------------------------------------------------|-------------------|
| `Time (s)`             | Time at which data was recorded.                   | Seconds (s)       |
| `Acceleration x (m/s^2)` | Linear acceleration along the x-axis (forward).     | m/s²              |
| `Acceleration y (m/s^2)` | Linear acceleration along the y-axis (sideways).    | m/s²              |
| `Acceleration z (m/s^2)` | Linear acceleration along the z-axis (downward).    | m/s²              |

**Notes**:  
- The x-axis points **forward** along the nose of the plane.  
- The y-axis points **sideways** (to the right wing).  
- The z-axis points **downward** relative to the plane.  
- Data is recorded at a consistent time step.

---

### 2. Gyroscope Data
**File Name**: `Gyroscope.csv`  

| **Column Name**        | **Description**                                     | **Unit**          |
|------------------------|-----------------------------------------------------|-------------------|
| `Time (s)`             | Time at which data was recorded.                   | Seconds (s)       |
| `Angular Rate x (deg/s)` | Rotation rate around the x-axis (pitch).            | Degrees per second (°/s) |
| `Angular Rate y (deg/s)` | Rotation rate around the y-axis (roll).             | Degrees per second (°/s) |
| `Angular Rate z (deg/s)` | Rotation rate around the z-axis (yaw).              | Degrees per second (°/s) |

**Notes**:  
- Angular rates are measured in degrees per second.  
- **Pitch** (x-axis): Rotation around the aircraft's lateral axis.  
- **Roll** (y-axis): Rotation around the longitudinal axis.  
- **Yaw** (z-axis): Rotation around the vertical axis.  

---

### 3. Location Data
**File Name**: `Location.csv`  

| **Column Name**        | **Description**                                     | **Unit**          |
|------------------------|-----------------------------------------------------|-------------------|
| `Time (s)`             | Time at which data was recorded.                   | Seconds (s)       |
| `Latitude (deg)`       | Latitude position of the aircraft.                 | Degrees (°)       |
| `Longitude (deg)`      | Longitude position of the aircraft.                | Degrees (°)       |
| `Altitude (m)`         | Altitude above sea level.                          | Meters (m)        |

**Notes**:  
- Latitude and Longitude are recorded in decimal degrees.  
- Altitude is measured relative to **mean sea level (MSL)**.  
- Data is time-aligned with accelerometer and gyroscope measurements.

---

## Usage Notes
1. All three datasets are **time-synchronized** to enable combined analysis of motion, orientation, and location.
2. For consistency:
   - Time columns (`Time (s)`) are identical across all datasets.
   - Sensor axes are defined relative to the aircraft's body frame.
3. Data can be used for:
   - Flight dynamics analysis.
   - Validation of physics-based models.
   - Integration into Simulink for model comparisons.

---

## Example Applications
- Use **Accelerometer data** to compute velocity and displacement through numerical integration.
- Use **Gyroscope data** to monitor the aircraft's angular rates during takeoff and landing.
- Use **Location data** to map flight trajectories and determine distances traveled.

---

## File Overview
- `Accelerometer.csv`: Contains linear acceleration data.  
- `Gyroscope.csv`: Contains angular rate (rotation) data.  
- `Location.csv`: Contains geographic position and altitude data.  
