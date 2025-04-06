import React, { useContext, useState, useEffect } from 'react'
import { ModuleContext } from '../context/ModuleState'
import { Input, Select, Modal, Table } from 'antd'
import ISection from '../assets/ISection.png'
import CustomSectionModal from './CustomSectionModal'
import axios from 'axios'
import Variable from '../Variable'

const readOnlyFontStyle = {
    color: 'rgb(0 0 0 / 67%)', fontSize: '12px', fontWeight: '600'
}

// Base API URL
const baseUrl = Variable.API_URL;

const ColumnSectionModal = (props) => {
    // Support for both old and new interface patterns
    const {
        // Old interface
        supportingSectionData, 
        designPrefInputs, 
        setDesignPrefInputs,
        // New interface
        visible = false,
        onCancel,
        onOk,
        onSelectSection,
        resetFlag
    } = props;

    const { materialList, updateSourceAndMechType, getMaterialDetails, supporting_material_details } = useContext(ModuleContext)
    const [showModal, setShowModal] = useState(false);
    const [sections, setSections] = useState([]);
    const [loading, setLoading] = useState(false);
    const [selectedSection, setSelectedSection] = useState(null);

    useEffect(() => {
        if (visible) {
            fetchSections();
        }
    }, [visible]);

    useEffect(() => {
        if (designPrefInputs && materialList.length > 0) {
            const material = materialList.filter(value => value.Grade === designPrefInputs.supporting_material);
            if (material && material.length > 0) {
                getMaterialDetails({data: material[0], type: "supporting"});
            }
        }
    }, [designPrefInputs, materialList]);

    const fetchSections = async () => {
        setLoading(true);
        try {
            const response = await axios.get(`${baseUrl}/sections/columns`);
            if (response.data && response.data.length > 0) {
                setSections(response.data);
            }
        } catch (error) {
            console.error('Error fetching column sections:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleRowSelection = (record) => {
        setSelectedSection(record.Designation);
    };

    const handleOk = () => {
        if (onSelectSection && selectedSection) {
            onSelectSection(selectedSection);
        } else if (onOk && selectedSection) {
            onOk(selectedSection);
        }
    };

    // New interface for Column Cover Plate components
    if (visible !== undefined) {
        const columns = [
            {
                title: 'Designation',
                dataIndex: 'Designation',
                key: 'Designation',
                sorter: (a, b) => {
                    return a.Designation.localeCompare(b.Designation);
                }
            },
            {
                title: 'Mass (kg/m)',
                dataIndex: 'Mass',
                key: 'Mass',
                sorter: (a, b) => a.Mass - b.Mass
            },
            {
                title: 'Depth (mm)',
                dataIndex: 'D',
                key: 'D',
                sorter: (a, b) => a.D - b.D
            },
            {
                title: 'Flange Width (mm)',
                dataIndex: 'B',
                key: 'B',
                sorter: (a, b) => a.B - b.B
            },
            {
                title: 'Web Thickness (mm)',
                dataIndex: 'tw',
                key: 'tw',
                sorter: (a, b) => a.tw - b.tw
            },
            {
                title: 'Flange Thickness (mm)',
                dataIndex: 'T',
                key: 'T',
                sorter: (a, b) => a.T - b.T
            }
        ];

        return (
            <Modal
                title="Select Column Section"
                visible={visible}
                onCancel={onCancel}
                onOk={handleOk}
                width={800}
                okButtonProps={{ disabled: !selectedSection }}
            >
                <div className="section-selection-container">
                    <Table
                        columns={columns}
                        dataSource={sections}
                        rowKey="Designation"
                        loading={loading}
                        pagination={{ pageSize: 10 }}
                        size="small"
                        scroll={{ y: 300 }}
                        onRow={(record) => ({
                            onClick: () => handleRowSelection(record),
                            style: { 
                                cursor: 'pointer',
                                background: selectedSection === record.Designation ? '#e6f7ff' : 'inherit' 
                            }
                        })}
                    />
                </div>
            </Modal>
        );
    }

    // Old interface implementation
    return (
        <>
            <div className='col-beam-cont'>
                <div>
                    <div className='input-cont'>
                        <h5>Designation</h5>
                        <Input
                            type="text"
                            name="Designation"
                            className='input-design-pref'
                            value={supportingSectionData.Designation}
                            disabled
                            style={readOnlyFontStyle}
                        />
                    </div>
                    <div className='sub-container'>
                        <h4>Mechanical Properties</h4>
                        <div className='input-cont'>
                            <h5>Material</h5>
                            <div>
                                <Select style={{ width: '200px', height: '25px', fontSize: '12px' }}
                                    value={designPrefInputs.supporting_material}
                                    onSelect={(value) => {
                                        if(value == -1){
                                            setShowModal(true)
                                            return;
                                        }
                                        const material = materialList.find(item => item.id === value)
                                        setDesignPrefInputs({ ...designPrefInputs, supporting_material: material.Grade })
                                        updateSourceAndMechType(1, material.Grade )
                                        getMaterialDetails({data: material , type: "supporting"})
                                    }}
                                >
                                    {materialList.map((item) => {
                                        return <Option key={item.id} value={item.id}>{item.Grade}</Option>
                                    })}
                                </Select>
                            </div>
                        </div>
                        <div className='input-cont'>
                            <h5>Ultimate Strength, Fu (MPa)</h5>
                            <Input
                                type="text"
                                name="ultimate-strength"
                                className='input-design-pref'
                                value={supporting_material_details[0] ? supporting_material_details[0].Ultimate_Tensile_Stress : 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Yield Strength, Fy (MPa)</h5>
                            <Input
                                type="text"
                                name="yield-strength"
                                className='input-design-pref'
                                value={supporting_material_details[0] ? supporting_material_details[0].Yield_Stress_greater_than_40 : 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Modulus of Elasticity, E (GPa)</h5>
                            <Input
                                type="text"
                                name="modulus-elasticity"
                                className='input-design-pref'
                                value={200}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Modulus of Rigidity, G (GPa)</h5>
                            <Input
                                type="text"
                                name="modulus-rigidity"
                                className='input-design-pref'
                                value={76.9}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Poisson's Ratio, v</h5>
                            <Input
                                type="text"
                                name="poisson-ratio"
                                className='input-design-pref'
                                value={0.3}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Thermal Expansion Coefficient (x10^(-8) / C)</h5>
                            <Input
                                type="text"
                                name="thermal-coefficient"
                                className='input-design-pref'
                                value={12}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Type</h5>
                            <div>
                                <Select style={{ width: '200px', height: '25px', fontSize: '12px' }}
                                    value={supportingSectionData.Type ? supportingSectionData.Type : "Rolled"}
                                    disabled
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
                                disabled
                                style={readOnlyFontStyle}
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
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Flange Width, B (mm)*</h5>
                            <Input
                                type="text"
                                name="flange-widht"
                                className='input-design-pref'
                                value={supportingSectionData.B || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Flange Thickness, T (mm)*</h5>
                            <Input
                                type="text"
                                name="flange-thickness"
                                className='input-design-pref'
                                value={supportingSectionData.T || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Web Thickness, t (mm)*</h5>
                            <Input
                                type="text"
                                name="web-thickness"
                                className='input-design-pref'
                                value={supportingSectionData.tw || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Flange Slope, a (deg.)*</h5>
                            <Input
                                type="text"
                                name="flange-slope"
                                className='input-design-pref'
                                value={supportingSectionData.FlangeSlope || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Root Radius, R1 (mm)*</h5>
                            <Input
                                type="text"
                                name="depth"
                                className='input-design-pref'
                                value={supportingSectionData.R1 || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Toe Radius, R2 (mm)*</h5>
                            <Input
                                type="text"
                                name="tow-radius"
                                className='input-design-pref'
                                value={supportingSectionData.R2 || 0}
                                disabled
                                style={readOnlyFontStyle}
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
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Sectional Area, a (cm2)</h5>
                            <Input
                                type="text"
                                name="sectional-area"
                                className='input-design-pref'
                                value={supportingSectionData.Area || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>2nd Moment of Area, Iz (cm4)</h5>
                            <Input
                                type="text"
                                name="2nd-moment-area-Iz"
                                className='input-design-pref'
                                value={supportingSectionData.Iz || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>2nd Moment of Area, Iy (cm4)</h5>
                            <Input
                                type="text"
                                name="2nd-moment-area-Iy"
                                className='input-design-pref'
                                value={supportingSectionData.Iy || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Radius of Gyration, Rz (cm4)</h5>
                            <Input
                                type="text"
                                name="radius-gyration-Rz"
                                className='input-design-pref'
                                value={supportingSectionData.rz || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Radius of Gyration, Ry (cm4)</h5>
                            <Input
                                type="text"
                                name="radius-gyration-Ry"
                                className='input-design-pref'
                                value={supportingSectionData.ry || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Elastic Modulus, Zz (cm3)</h5>
                            <Input
                                type="text"
                                name="elastic-modulus"
                                className='input-design-pref'
                                value={supportingSectionData.Zz || 0}
                                disabled
                                style={readOnlyFontStyle}
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
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Plastic Modulus, Zpv (cm3)</h5>
                            <Input
                                type="text"
                                name="plastic-modulus-pv"
                                className='input-design-pref'
                                value={supportingSectionData.Zpy || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Torsion Constant, It (cm4)</h5>
                            <Input
                                type="text"
                                name="torsion-constant"
                                className='input-design-pref'
                                value={supportingSectionData.It || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                        <div className='input-cont'>
                            <h5>Warping Constant, Iw (cm6)</h5>
                            <Input
                                type="text"
                                name="warping-constant"
                                className='input-design-pref'
                                value={supportingSectionData.Iw || 0}
                                disabled
                                style={readOnlyFontStyle}
                            />
                        </div>
                    </div>
                </div>
            </div>
            <CustomSectionModal 
                showModal={showModal}
                setShowModal={setShowModal}
                setInputValues={setDesignPrefInputs}
                inputValues={designPrefInputs}
                type='supporting'
            />
        </>
    )
}

export default ColumnSectionModal;