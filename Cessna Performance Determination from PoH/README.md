# Estimation of Drag Polar and Performance for the C-172S

This assignment focuses on analyzing the drag polar and overall performance of the Cessna 172S aircraft used on the ERAU flight line. By using data from the aircraft manual, students will compute key aerodynamic parameters and generate performance plots.

## Objectives

1. **Determine Aerodynamic Parameters**: Using six data points from the Pilot's Operating Handbook (POH) for ISA 0 at 2,000' altitude, calculate:
   - Oswald's efficiency factor (\(e\)).
   - Equivalent flat plate area (\(f\)).

2. **Plot Performance Characteristics**:
   - Total drag vs. speed (70 knots to 120 knots).
   - Thrust vs. speed.
   - Power required and power available vs. speed.
   - Excess power vs. speed.
   - Rate of climb (ft/min) vs. speed.
   - Lift-to-drag ratio (\(L/D\)) vs. speed.

## Data Source

**C-172S Manual**: Basic aircraft specifications, including wing area, wingspan, gross weight, and engine power, are sourced from the manual's front section. Page 131 (5-19) provides the required performance data.
  
<details>
<summary> Cruise Performance Tables </summary> 
![](Imgs/Cruise Performance Tables.png)
</details>

<details>
<summary> Determining PV vs V^4 Diagram </summary> 
  ![](Imgs/PV)
</details>

## Assumptions
- Propeller efficiency (\(η_p\)) is constant at 0.80 across all data points.
- Calculations and plots assume standard conditions (ISA 0).
## Equations

The following equations were used in the analysis:

1. **Power Available vs. Speed**:
   PV = mV² = (1/2) * ρ * V⁴ * f + (2 / (ρ * π * e)) * (W / b)²

2. **Linear Regression Equation**:
   Y = 0.0066x + 1,703,714

3. **Slope of Drag Polar (m)**:
   m = (1/2) * ρ * f

4. **Oswald's Efficiency Factor (b)**:
   b = (2 / (ρ * π * e)) * (W / b)²


## Deliverables

1. Accurate estimation of aerodynamic parameters (\(e\) and \(f\)).
2. Visual performance plots for the specified conditions.
![](Imgs/plots_POH.png)
