import React, { useContext } from 'react'
import { ModuleContext } from '../context/ModuleState'
import { Input, Select } from 'antd'
import ISection from '../assets/ISection.png'
const ColumnSectionModal = ({ inputs, setInputs, supportingSectionData }) => {

    const { materialList } = useContext(ModuleContext)

    return (
        <div className='col-beam-cont'>
            <div>
                <div className='input-cont'>
                    <h5>Designation</h5>
                    <Input
                        type="text"
                        name="Designation"
                        className='input-design-pref'
                        value={'HB 150'}
                    />
                </div>
                <div className='sub-container'>
                    <h4>Mechanical Properties</h4>
                    <div className='input-cont'>
                        <h5>Material</h5>
                        <div>
                            <Select style={{ width: '200px', height: '25px',fontSize: '12px' }}
                                value={inputs.connector_material || materialList[0]}
                                onSelect={(value) => setInputs({ ...inputs, connector_material: value })}
                            >
                                {materialList.map((item, index) => (
                                    <Option key={index} value={item}>{item}</Option>
                                ))}
                            </Select>
                        </div>
                    </div>
                    <div className='input-cont'>
                        <h5>Ultimate Strength, Fu (MPa)</h5>
                        <Input
                            type="text"
                            name="ultimate-strength"
                            className='input-design-pref'
                            value={'0'}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Yield Strength, Fy (MPa)</h5>
                        <Input
                            type="text"
                            name="yield-strength"
                            className='input-design-pref'
                            value={'0'}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Modulus of Elasticity, E (GPa)</h5>
                        <Input
                            type="text"
                            name="modulus-elasticity"
                            className='input-design-pref'
                            value={'0'}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Modulus of Rigidity, G (GPa)</h5>
                        <Input
                            type="text"
                            name="modulus-rigidity"
                            className='input-design-pref'
                            value={'0'}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Poisson's Ratio, v</h5>
                        <Input
                            type="text"
                            name="poisson-ratio"
                            className='input-design-pref'
                            value={'0'}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Thermal Expansion Coefficient (x10^(-8) / C)</h5>
                        <Input
                            type="text"
                            name="thermal-coefficient"
                            className='input-design-pref'
                            value={'0'}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Type</h5>
                        <div>
                            <Select style={{ width: '200px', height: '25px', fontSize: '12px' }}
                                value={'Rolled'}
                            //onSelect={(value) => setInputs({ ...inputs, connector_material: value })}
                            >
                                {['Rolled', 'Welded'].map((item, index) => (
                                    <Option key={index} value={item}>{item}</Option>
                                ))}
                            </Select>
                        </div>
                    </div>
                    <div className='input-cont'>
                        <h5>Source</h5>
                        <Input
                            type="text"
                            name="source"
                            className='input-design-pref'
                            value={supportingSectionData.Source || 0}
                        />
                    </div>
                </div>
            </div>
            {/*  */}
            <div>
                <div className='sub-container'>
                    <h4>Dimensions</h4>
                    <div className='input-cont'>
                        <h5>Depth, D (mm)*</h5>
                        <Input
                            type="text"
                            name="depth"
                            className='input-design-pref'
                            value={supportingSectionData.D || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Flange Width, B (mm)*</h5>
                        <Input
                            type="text"
                            name="flange-widht"
                            className='input-design-pref'
                            value={supportingSectionData.B || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Flange Thickness, T (mm)*</h5>
                        <Input
                            type="text"
                            name="flange-thickness"
                            className='input-design-pref'
                            value={supportingSectionData.T || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Web Thickness, t (mm)*</h5>
                        <Input
                            type="text"
                            name="web-thickness"
                            className='input-design-pref'
                            value={supportingSectionData.tw || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Flange Slope, a (deg.)*</h5>
                        <Input
                            type="text"
                            name="flange-slope"
                            className='input-design-pref'
                            value={supportingSectionData.FlangeSlope || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Root Radius, R1 (mm)*</h5>
                        <Input
                            type="text"
                            name="depth"
                            className='input-design-pref'
                            value={supportingSectionData.R1 || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Toe Radius, R2 (mm)*</h5>
                        <Input
                            type="text"
                            name="tow-radius"
                            className='input-design-pref'
                            value={supportingSectionData.R2 || 0}
                        />
                    </div>
                </div>
                <div className="sub-container">
                    <h4>Section Properties</h4>
                    <div className='input-cont'>
                        <h5>Mass, M (Kg/m)</h5>
                        <Input
                            type="text"
                            name="mass"
                            className='input-design-pref'
                            value={supportingSectionData.Mass || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Sectional Area, a (cm2)</h5>
                        <Input
                            type="text"
                            name="sectional-area"
                            className='input-design-pref'
                            value={supportingSectionData.Area || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>2nd Moment of Area, Iz (cm4)</h5>
                        <Input
                            type="text"
                            name="2nd-moment-area-Iz"
                            className='input-design-pref'
                            value={supportingSectionData.Iz || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>2nd Moment of Area, Iy (cm4)</h5>
                        <Input
                            type="text"
                            name="2nd-moment-area-Iy"
                            className='input-design-pref'
                            value={supportingSectionData.Iy || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Radius of Gyration, Rz (cm4)</h5>
                        <Input
                            type="text"
                            name="radius-gyration-Rz"
                            className='input-design-pref'
                            value={supportingSectionData.rz || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Radius of Gyration, Ry (cm4)</h5>
                        <Input
                            type="text"
                            name="radius-gyration-Ry"
                            className='input-design-pref'
                            value={supportingSectionData.ry || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Elastic Modulus, Zz (cm3)</h5>
                        <Input
                            type="text"
                            name="elastic-modulus"
                            className='input-design-pref'
                            value={supportingSectionData.Zz || 0}
                        />
                    </div>
                </div>
            </div>
            {/*  */}

            <div>
                <div className='sub-container'>
                    <img src={ISection} alt="image" />
                </div>
                <div className='sub-container'>
                    <h4>Section Properties</h4>
                    <div className='input-cont'>
                        <h5>Plastic Modulus, Zpz (cm3)</h5>
                        <Input
                            type="text"
                            name="plastic-modulus-pz"
                            className='input-design-pref'
                            value={supportingSectionData.Zpz || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Plastic Modulus, Zpv (cm3)</h5>
                        <Input
                            type="text"
                            name="plastic-modulus-pv"
                            className='input-design-pref'
                            value={supportingSectionData.Zpy || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Torsion Constant, It (cm4)</h5>
                        <Input
                            type="text"
                            name="torsion-constant"
                            className='input-design-pref'
                            value={supportingSectionData.It || 0}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Warping Constant, Iw (cm6)</h5>
                        <Input
                            type="text"
                            name="warping-constant"
                            className='input-design-pref'
                            value={supportingSectionData.Iw || 0}
                        />
                    </div>
                </div>
            </div>
        </div>
    )
}

export default ColumnSectionModal