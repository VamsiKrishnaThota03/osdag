import { Select, Input, Modal } from 'antd'
import { useState, useEffect } from 'react'

const { Option } = Select;

const DesignSectionModal = (props) => {
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
        "Design.Design_Method": initialValues["Design.Design_Method"] || "Limit State Design"
    });

    // Reset values on resetFlag change
    useEffect(() => {
        if (resetFlag && initialValues) {
            setFormValues({
                "Design.Design_Method": initialValues["Design.Design_Method"] || "Limit State Design"
            });
        }
    }, [resetFlag, initialValues]);

    const handleDesignMethodChange = (value) => {
        setFormValues({
            ...formValues,
            "Design.Design_Method": value
        });
    };

    const handleOk = () => {
        if (onOk) {
            onOk({
                "Design.Design_Method": formValues["Design.Design_Method"]
            });
        }
    };

    // If using new interface for Column Cover Plate components
    if (visible !== undefined) {
        return (
            <Modal
                title="Design Method"
                visible={visible}
                onCancel={onCancel}
                onOk={handleOk}
                maskClosable={false}
                width={500}
            >
                <div className="design-method-section">
                    <h4>Design Method</h4>
                    <Select
                        value={formValues["Design.Design_Method"]}
                        style={{ width: 300 }}
                        onChange={handleDesignMethodChange}
                    >
                        <Option value="Limit State Design">Limit State Design</Option>
                        <Option value="Limit State (capacity based) Design" disabled>Limit State (capacity based) Design</Option>
                        <Option value="Working Stressed Design" disabled>Working Stressed Design</Option>
                    </Select>
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
                        <h5>Design Method</h5>
                        <div>
                            <Select 
                                style={{ width: '200px', height: '25px', fontSize: '12px' }}
                                value={designPrefInputs && designPrefInputs.design_method}
                                onSelect={value => setDesignPrefInputs && setDesignPrefInputs({...designPrefInputs, design_method: value})}
                            >
                                <Option value="Limited State Design">Limited State Design</Option>
                                <Option value="Limited State (capacity based) Design" disabled>Limited State (capacity based) Design</Option>
                                <Option value="Working Stressed Design" disabled>Working Stressed Design</Option>
                            </Select>
                        </div>
                    </div>
                </div>
            </div>
            {/*  */}
            {/* <div>
                <div className="sub-container">
                    <h4>Discription</h4>
                    <Input.TextArea rows={25} cols={150} />
                </div>
            </div> */}
           

        </div>
    );
}

export default DesignSectionModal