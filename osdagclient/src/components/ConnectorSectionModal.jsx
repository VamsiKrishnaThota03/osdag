import { useContext, useEffect, useState } from 'react'
import { ModuleContext } from '../context/ModuleState'
import { Input, Select, Modal } from 'antd'
import CustomSectionModal from './CustomSectionModal'

const { Option } = Select;

const readOnlyFontStyle = {
    color: 'rgb(0 0 0 / 67%)', fontSize: '12px', fontWeight: '600'
}

const ConnectorSectionModal = (props) => {
    // Support for both old and new interface patterns
    const {
        // Old interface
        designPrefInputs, 
        setDesignPrefInputs,
        // New interface
        visible = false,
        onCancel,
        onOk,
        initialValues = {},
        moduleType = "",
        resetFlag
    } = props;

    const { materialList, conn_material_details, getMaterialDetails } = useContext(ModuleContext)
    const [showModal, setShowModal] = useState(false)
    
    // State for new interface
    const [formValues, setFormValues] = useState({
        "Connector.Flange_Plate.Thickness_List": initialValues["Connector.Flange_Plate.Thickness_List"] || [],
        "Connector.Web_Plate.Thickness_List": initialValues["Connector.Web_Plate.Thickness_List"] || [],
        "Connector.Material": initialValues["Connector.Material"] || "",
    });

    useEffect(() => {
        // For old interface
        if (designPrefInputs) {
            const material = materialList.filter(value => value.Grade === designPrefInputs.supported_material)
            if (material && material.length > 0) {
                getMaterialDetails({data: material[0], type: "connector"})
            }
        }
    }, [designPrefInputs, moduleType])

    // Reset values on resetFlag change
    useEffect(() => {
        if (resetFlag && initialValues) {
            setFormValues({
                "Connector.Flange_Plate.Thickness_List": initialValues["Connector.Flange_Plate.Thickness_List"] || [],
                "Connector.Web_Plate.Thickness_List": initialValues["Connector.Web_Plate.Thickness_List"] || [],
                "Connector.Material": initialValues["Connector.Material"] || "",
            });
        }
    }, [resetFlag]);

    const handleMaterialChange = value => {
        // For old interface
        if (designPrefInputs) {
            if(value == -1){
                setShowModal(true)
                return;
            }
            const material = materialList.find(item => item.id === value)
            setDesignPrefInputs({ ...designPrefInputs, connector_material: material.Grade })
            
            getMaterialDetails({data: material, type: "connector"})
        }
        // For new interface
        else {
            setFormValues({
                ...formValues,
                "Connector.Material": value
            });
        }
    }

    const handleThicknessChange = (field, value) => {
        setFormValues({
            ...formValues,
            [field]: value
        });
    }

    const handleOk = () => {
        if (onOk) {
            onOk({
                "Connector.Flange_Plate.Thickness_List": formValues["Connector.Flange_Plate.Thickness_List"],
                "Connector.Web_Plate.Thickness_List": formValues["Connector.Web_Plate.Thickness_List"],
                "Connector.Material": formValues["Connector.Material"]
            });
        }
    }

    // If using new interface for Column Cover Plate
    if (visible !== undefined) {
        return (
            <Modal
                title="Connector Properties"
                visible={visible}
                onCancel={onCancel}
                onOk={handleOk}
                maskClosable={false}
                width={600}
            >
                <div className="connector-modal-content">
                    <div className="connector-section">
                        <h4>Material</h4>
                        <Select
                            value={formValues["Connector.Material"]}
                            style={{ width: 300 }}
                            onChange={value => handleThicknessChange("Connector.Material", value)}
                        >
                            <Option value="E 165 (Fe 290)">E 165 (Fe 290)</Option>
                            <Option value="E 250 (Fe 410 W)A">E 250 (Fe 410 W)A</Option>
                            <Option value="E 250 (Fe 410 W)B">E 250 (Fe 410 W)B</Option>
                            <Option value="E 250 (Fe 410 W)C">E 250 (Fe 410 W)C</Option>
                            <Option value="E 300 (Fe 440)">E 300 (Fe 440)</Option>
                            <Option value="E 350 (Fe 490)">E 350 (Fe 490)</Option>
                            <Option value="E 410 (Fe 540)">E 410 (Fe 540)</Option>
                            <Option value="E 450 (Fe 570)D">E 450 (Fe 570)D</Option>
                            <Option value="E 450 (Fe 590)E">E 450 (Fe 590)E</Option>
                        </Select>
                    </div>
                    
                    <div className="connector-section">
                        <h4>Flange Plate Thickness List (mm)</h4>
                        <Select
                            mode="multiple"
                            value={formValues["Connector.Flange_Plate.Thickness_List"]}
                            style={{ width: 300 }}
                            onChange={value => handleThicknessChange("Connector.Flange_Plate.Thickness_List", value)}
                        >
                            <Option value="6">6</Option>
                            <Option value="8">8</Option>
                            <Option value="10">10</Option>
                            <Option value="12">12</Option>
                            <Option value="14">14</Option>
                            <Option value="16">16</Option>
                            <Option value="18">18</Option>
                            <Option value="20">20</Option>
                            <Option value="22">22</Option>
                            <Option value="24">24</Option>
                            <Option value="26">26</Option>
                            <Option value="28">28</Option>
                            <Option value="30">30</Option>
                            <Option value="32">32</Option>
                            <Option value="36">36</Option>
                            <Option value="40">40</Option>
                            <Option value="45">45</Option>
                            <Option value="50">50</Option>
                            <Option value="56">56</Option>
                            <Option value="63">63</Option>
                        </Select>
                    </div>
                    
                    <div className="connector-section">
                        <h4>Web Plate Thickness List (mm)</h4>
                        <Select
                            mode="multiple"
                            value={formValues["Connector.Web_Plate.Thickness_List"]}
                            style={{ width: 300 }}
                            onChange={value => handleThicknessChange("Connector.Web_Plate.Thickness_List", value)}
                        >
                            <Option value="6">6</Option>
                            <Option value="8">8</Option>
                            <Option value="10">10</Option>
                            <Option value="12">12</Option>
                            <Option value="14">14</Option>
                            <Option value="16">16</Option>
                            <Option value="18">18</Option>
                            <Option value="20">20</Option>
                            <Option value="22">22</Option>
                            <Option value="24">24</Option>
                            <Option value="26">26</Option>
                            <Option value="28">28</Option>
                            <Option value="30">30</Option>
                            <Option value="32">32</Option>
                            <Option value="36">36</Option>
                            <Option value="40">40</Option>
                            <Option value="45">45</Option>
                            <Option value="50">50</Option>
                            <Option value="56">56</Option>
                            <Option value="63">63</Option>
                        </Select>
                    </div>
                </div>
            </Modal>
        );
    }
    
    // Old interface implementation
    return (
        <div className='Connector-col-beam-cont'>
            <div>
                <div className='sub-container'>
                    <div className='input-cont'>
                        <h5>Material</h5>
                        <div>
                            <Select style={{ width: '200px', height: '25px',fontSize: '12px' }}
                                value={designPrefInputs && designPrefInputs.connector_material}
                                onSelect={(value) => {
                                    handleMaterialChange(value)
                                }}
                            >
                                {materialList.map((item, index) => {
                                    return (
                                        <Option key={index} value={item.id}>{item.Grade}</Option>
                                    )
                                })}
                            </Select>
                        </div>
                    </div>
                    <div className='input-cont'>
                        <h5>Ultimate Strength, Fu (Mpa)</h5>
                        <Input
                            type="text"
                            name="ultimate-strength"
                            className='input-design-pref'
                            value={conn_material_details[0] ? conn_material_details[0].Ultimate_Tensile_Stress : 0}
                            disabled
                            style={readOnlyFontStyle}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Yield  Strength, Fy (Mpa) (0-20mm)</h5>
                        <Input
                            type="text"
                            name="yield-strength"
                            className='input-design-pref'
                            value={conn_material_details[0] ? conn_material_details[0].Yield_Stress_less_than_20 : 0}
                            disabled
                            style={readOnlyFontStyle}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>Yield  Strength, Fy (Mpa) (20-40mm)</h5>
                        <Input
                            type="text"
                            name="modulus-elasticity"
                            className='input-design-pref'
                            value={conn_material_details[0] ? conn_material_details[0].Yield_Stress_between_20_and_neg40 : 0}
                            disabled
                            style={readOnlyFontStyle}
                        />
                    </div>
                    <div className='input-cont'>
                        <h5>{`Yield  Strength, Fy (Mpa) (>40mm)`}</h5>
                        <Input
                            type="text"
                            name="modulus-rigidity"
                            className='input-design-pref'
                            value={conn_material_details[0] ? conn_material_details[0].Yield_Stress_greater_than_40 : 0}
                            disabled
                            style={readOnlyFontStyle}
                        />
                    </div>
                    </div>
            </div>
            <CustomSectionModal 
                showModal={showModal}
                setShowModal={setShowModal}
                setInputValues={setDesignPrefInputs}
                inputValues={designPrefInputs}
                type="connector"
            />
        </div>
    )
}

export default ConnectorSectionModal