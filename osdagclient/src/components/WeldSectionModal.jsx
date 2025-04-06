import { Select, Input, Modal } from 'antd'
import { useState, useEffect } from 'react'

const { Option } = Select;

const Weld_text = `Shop weld takes a material safety factor of 1.25
Field weld takes a material safety factor of 1.5
(IS 800 - cl. 5. 4. 1 or Table 5)`;

const WeldSectionModal = (props) => {
    // Support for both old and new interface patterns
    const {
        // Old interface
        inputs,
        setInputs,
        designPrefInputs, 
        setDesignPrefInputs,
        // New interface
        visible = false,
        onCancel,
        onOk,
        initialValues = {},
        resetFlag
    } = props;

    // State for new interface
    const [formValues, setFormValues] = useState({
        "Weld.Fab": initialValues["Weld.Fab"] || "Shop Weld",
        "Weld.Material_Grade_OverWrite": initialValues["Weld.Material_Grade_OverWrite"] || "410"
    });

    // Reset values on resetFlag change
    useEffect(() => {
        if (resetFlag && initialValues) {
            setFormValues({
                "Weld.Fab": initialValues["Weld.Fab"] || "Shop Weld",
                "Weld.Material_Grade_OverWrite": initialValues["Weld.Material_Grade_OverWrite"] || "410"
            });
        }
    }, [resetFlag, initialValues]);

    const handleFormChange = (field, value) => {
        setFormValues({
            ...formValues,
            [field]: value
        });
    };

    const handleOk = () => {
        if (onOk) {
            onOk({
                "Weld.Fab": formValues["Weld.Fab"],
                "Weld.Material_Grade_OverWrite": formValues["Weld.Material_Grade_OverWrite"]
            });
        }
    };

    // If using new interface for Column Cover Plate components
    if (visible !== undefined) {
        return (
            <Modal
                title="Weld Properties"
                visible={visible}
                onCancel={onCancel}
                onOk={handleOk}
                maskClosable={false}
                width={500}
            >
                <div className="weld-modal-content">
                    <div className="weld-section">
                        <h4>Type of Weld Fabrication</h4>
                        <Select
                            value={formValues["Weld.Fab"]}
                            style={{ width: 300 }}
                            onChange={(value) => handleFormChange("Weld.Fab", value)}
                        >
                            <Option value="Shop Weld">Shop Weld</Option>
                            <Option value="Field Weld">Field Weld</Option>
                        </Select>
                    </div>
                    
                    <div className="weld-section">
                        <h4>Material Grade Overwrite, Fu (MPa)</h4>
                        <Input
                            value={formValues["Weld.Material_Grade_OverWrite"]}
                            style={{ width: 300 }}
                            onChange={(e) => handleFormChange("Weld.Material_Grade_OverWrite", e.target.value)}
                        />
                    </div>
                    
                    <div className="weld-section description">
                        <h4>Description</h4>
                        <Input.TextArea 
                            rows={5} 
                            value={Weld_text} 
                            readOnly 
                            style={{ width: '100%' }}
                        />
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
                    <h4>Inputs</h4>
                    <div className='input-cont'>
                        <h5>Type of Weld Fabrication</h5>
                        <div>
                            <Select style={{ width: '200px', height: '25px',fontSize: '12px' }}
                                value={designPrefInputs && designPrefInputs.weld_fab}
                                onSelect={value => designPrefInputs && setDesignPrefInputs && setDesignPrefInputs({...designPrefInputs, weld_fab: value})}
                            >
                                <Option value="Shop Weld">Shop Weld</Option>
                                <Option value="Field Weld">Field Weld</Option>
                            </Select>
                        </div>
                    </div>
                    <div className='input-cont'>
                        <h5>Material Grade Overwrite, Fu (MPa) </h5>
                        <div>
                            <Input
                                type="text"
                                name="source"
                                className='input-design-pref'
                                value={designPrefInputs && designPrefInputs.weld_material_grade}
                                onChange={e => designPrefInputs && setDesignPrefInputs && setDesignPrefInputs({...designPrefInputs, weld_material_grade: e.target.value})}
                            />
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <div className="sub-container">
                    <h4>Description</h4>
                    <Input.TextArea rows={25} cols={150} value={Weld_text} readOnly/>
                </div>
            </div>
        </div>
    );
};

export default WeldSectionModal;