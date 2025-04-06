import { Select, Input, Modal } from 'antd'
import { useState, useEffect } from 'react'

const { Option } = Select;

const Detailing_text =`The minimum edge and end distances from the centre of any hole to the nearest edge of a plate shall not be less than 1.7 times the hole diameter in case of [sheared or hand flame cut edges] and 1.5 times the hole diameter in case of [Rolled, machine-flame cut, sawn and planed edges] (IS 800 - cl. 10. 2. 4. 2)

This gap should include the tolerance value of 5mm or 1.5mm. So if the assumed clearance is 5mm, then the gap should be = 10mm (= 5mm {clearance} + 5mm {tolerance} or if the assumed clearance is 1.5mm, then the gap should be = 3mm (= 1.5mm {clearance} + 1.5mm {tolerance}. These are the default gap values based on the site practice for convenience of erection and IS 7215,Clause 2.3.1. The gap value can also be zero based on the nature of connection where clearance is not required.

Specifying whether the members are exposed to corrosive influences, here, only affects the calculation of the maximum edge distance as per cl. 10.2.4.3`;

const DetailingSectionModal = (props) => {
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
        resetFlag
    } = props;

    // State for new interface
    const [formValues, setFormValues] = useState({
        "Detailing.Edge_type": initialValues["Detailing.Edge_type"] || "Rolled",
        "Detailing.Gap": initialValues["Detailing.Gap"] || "10",
        "Detailing.Corrosive_Influences": initialValues["Detailing.Corrosive_Influences"] || "No"
    });

    // Reset values on resetFlag change
    useEffect(() => {
        if (resetFlag && initialValues) {
            setFormValues({
                "Detailing.Edge_type": initialValues["Detailing.Edge_type"] || "Rolled",
                "Detailing.Gap": initialValues["Detailing.Gap"] || "10",
                "Detailing.Corrosive_Influences": initialValues["Detailing.Corrosive_Influences"] || "No"
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
                "Detailing.Edge_type": formValues["Detailing.Edge_type"],
                "Detailing.Gap": formValues["Detailing.Gap"],
                "Detailing.Corrosive_Influences": formValues["Detailing.Corrosive_Influences"]
            });
        }
    };

    // If using new interface for Column Cover Plate components
    if (visible !== undefined) {
        return (
            <Modal
                title="Detailing Properties"
                visible={visible}
                onCancel={onCancel}
                onOk={handleOk}
                maskClosable={false}
                width={600}
            >
                <div className="detailing-modal-content">
                    <div className="detailing-section">
                        <h4>Edge Preparation Method</h4>
                        <Select
                            value={formValues["Detailing.Edge_type"]}
                            style={{ width: 300 }}
                            onChange={(value) => handleFormChange("Detailing.Edge_type", value)}
                        >
                            <Option value="Sheared or hand flame cut">Sheared or hand flame cut</Option>
                            <Option value="Rolled">Rolled, machine-flame cut, sawn and planed</Option>
                        </Select>
                    </div>
                    
                    <div className="detailing-section">
                        <h4>Gap Between Beam And Support (mm)</h4>
                        <Input
                            value={formValues["Detailing.Gap"]}
                            style={{ width: 300 }}
                            onChange={(e) => handleFormChange("Detailing.Gap", e.target.value)}
                        />
                    </div>
                    
                    <div className="detailing-section">
                        <h4>Are the Members Exposed to Corrosive Influences?</h4>
                        <Select
                            value={formValues["Detailing.Corrosive_Influences"]}
                            style={{ width: 300 }}
                            onChange={(value) => handleFormChange("Detailing.Corrosive_Influences", value)}
                        >
                            <Option value="No">No</Option>
                            <Option value="Yes">Yes</Option>
                        </Select>
                    </div>
                    
                    <div className="detailing-section description">
                        <h4>Description</h4>
                        <Input.TextArea 
                            rows={8} 
                            value={Detailing_text} 
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
                        <h5>Edge Preparation Method</h5>
                        <div>
                            <Select style={{ width: '200px', height: '25px',fontSize: '12px' }}
                                value={designPrefInputs && designPrefInputs.detailing_edge_type}
                                onSelect={value => designPrefInputs && setDesignPrefInputs && setDesignPrefInputs({...designPrefInputs, detailing_edge_type: value})}
                            >
                                <Option value="Sheared or hand flame cut">Sheared or hand flame cut</Option>
                                <Option value="Rolled, machine-flame cut, sawn and planed">Rolled, machine-flame cut, sawn and planed</Option>
                            </Select>
                        </div>
                    </div>
                    <div className='input-cont'>
                        <h5>Gap Between Beam And Support (mm) </h5>
                        <div>
                            <Input
                                type="text"
                                name="source"
                                className='input-design-pref'
                                value={designPrefInputs && designPrefInputs.detailing_gap}
                                onChange={e => designPrefInputs && setDesignPrefInputs && setDesignPrefInputs({...designPrefInputs, detailing_gap: e.target.value})}
                            />
                        </div>
                    </div>
                    <div className='input-cont'>
                        <h5>Are the Member Exposed to Corrosive influences?</h5>
                        <div>
                            <Select style={{ width: '200px', height: '25px',fontSize: '12px' }}
                                value={designPrefInputs && designPrefInputs.detailing_corr_status}
                                onSelect={value => designPrefInputs && setDesignPrefInputs && setDesignPrefInputs({...designPrefInputs, detailing_corr_status: value})}
                            >
                                <Option value="No">No</Option>
                                <Option value="Yes">Yes</Option>
                            </Select>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <div className="sub-container">
                    <h4>Description</h4>
                    <Input.TextArea rows={25} cols={150} value={Detailing_text} readOnly />
                </div>
            </div>
        </div>
    );
};

export default DetailingSectionModal;