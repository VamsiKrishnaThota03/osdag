import { Select, Input, Modal } from 'antd'
import { useState, useEffect } from 'react'

const { Option } = Select;

const Bolt_description = `
IS 800 Table 20 Typical Average Values for Coefficient of Friction (µf)

Treatment of Surfaces     µ_f
i) Surfaces not treated   0.2
ii) Surfaces blasted with short or grit with any loose rust removed, no pitting   0.5
iii) Surfaces blasted with short or grit and hot-dip galvanized   0.1
iv) Surfaces blasted with short or grit and spray - metallized with zinc (thickness 50-70 µm)     0.25
v) Surfaces blasted with shot or grit and painted with ethylzinc silicate coat (thickness 30-60 µm)   0.3
vi) Sand blasted surface, after light rusting     0.52
vii) Surfaces blasted with shot or grit and painted with ethylzinc silicate coat (thickness 60-80 µm)     0.3
viii) Surfaces blasted with shot or grit and painted with alcalizinc silicate coat (thickness 60-80 µm)   0.3
ix) Surfaces blasted with shot or grit and spray metallized with aluminium (thickness >50 µm)     0.5
x) Clean mill scale   0.33
xi) Sand blasted surface      0.48
xii) Red lead painted surface     0.1
`;

const BoltSectionModal = (props) => {
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
        "Bolt.Type": initialValues["Bolt.Type"] || "Bearing Bolt",
        "Bolt.Diameter": initialValues["Bolt.Diameter"] || [],
        "Bolt.Grade": initialValues["Bolt.Grade"] || [],
        "Bolt.Bolt_Hole_Type": initialValues["Bolt.Bolt_Hole_Type"] || "Standard",
        "Bolt.TensionType": initialValues["Bolt.TensionType"] || "Non Pre-tensioned",
        "Bolt.Slip_Factor": initialValues["Bolt.Slip_Factor"] || "0.3"
    });

    // Reset values on resetFlag change
    useEffect(() => {
        if (resetFlag && initialValues) {
            setFormValues({
                "Bolt.Type": initialValues["Bolt.Type"] || "Bearing Bolt",
                "Bolt.Diameter": initialValues["Bolt.Diameter"] || [],
                "Bolt.Grade": initialValues["Bolt.Grade"] || [],
                "Bolt.Bolt_Hole_Type": initialValues["Bolt.Bolt_Hole_Type"] || "Standard",
                "Bolt.TensionType": initialValues["Bolt.TensionType"] || "Non Pre-tensioned",
                "Bolt.Slip_Factor": initialValues["Bolt.Slip_Factor"] || "0.3"
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
            onOk(formValues);
        }
    };

    // If using new interface for Column Cover Plate components
    if (visible !== undefined) {
        return (
            <Modal
                title="Bolt Properties"
                visible={visible}
                onCancel={onCancel}
                onOk={handleOk}
                maskClosable={false}
                width={600}
            >
                <div className="bolt-modal-content">
                    <div className="bolt-section">
                        <h4>Bolt Type</h4>
                        <Select
                            value={formValues["Bolt.Type"]}
                            style={{ width: 300 }}
                            onChange={(value) => handleFormChange("Bolt.Type", value)}
                        >
                            <Option value="Bearing Bolt">Bearing Bolt</Option>
                            <Option value="Friction Grip Bolt">Friction Grip Bolt</Option>
                        </Select>
                    </div>
                    
                    <div className="bolt-section">
                        <h4>Tension Type</h4>
                        <Select
                            value={formValues["Bolt.TensionType"]}
                            style={{ width: 300 }}
                            onChange={(value) => handleFormChange("Bolt.TensionType", value)}
                        >
                            <Option value="Pre-tensioned">Pre-tensioned</Option>
                            <Option value="Non Pre-tensioned">Non Pre-tensioned</Option>
                        </Select>
                    </div>
                    
                    <div className="bolt-section">
                        <h4>Bolt Hole Type</h4>
                        <Select
                            value={formValues["Bolt.Bolt_Hole_Type"]}
                            style={{ width: 300 }}
                            onChange={(value) => handleFormChange("Bolt.Bolt_Hole_Type", value)}
                        >
                            <Option value="Standard">Standard</Option>
                            <Option value="Over-Sized">Over-Sized</Option>
                        </Select>
                    </div>
                    
                    <div className="bolt-section">
                        <h4>Bolt Diameter (mm)</h4>
                        <Select
                            mode="multiple"
                            value={formValues["Bolt.Diameter"]}
                            style={{ width: 300 }}
                            onChange={(value) => handleFormChange("Bolt.Diameter", value)}
                        >
                            <Option value="12">12</Option>
                            <Option value="16">16</Option>
                            <Option value="20">20</Option>
                            <Option value="24">24</Option>
                            <Option value="30">30</Option>
                            <Option value="36">36</Option>
                        </Select>
                    </div>
                    
                    <div className="bolt-section">
                        <h4>Bolt Grade</h4>
                        <Select
                            mode="multiple"
                            value={formValues["Bolt.Grade"]}
                            style={{ width: 300 }}
                            onChange={(value) => handleFormChange("Bolt.Grade", value)}
                        >
                            <Option value="4.6">4.6</Option>
                            <Option value="4.8">4.8</Option>
                            <Option value="5.6">5.6</Option>
                            <Option value="6.8">6.8</Option>
                            <Option value="8.8">8.8</Option>
                            <Option value="9.8">9.8</Option>
                            <Option value="10.9">10.9</Option>
                            <Option value="12.9">12.9</Option>
                        </Select>
                    </div>
                    
                    <div className="bolt-section">
                        <h4>Slip Factor (μf)</h4>
                        <Select
                            value={formValues["Bolt.Slip_Factor"]}
                            style={{ width: 300 }}
                            onChange={(value) => handleFormChange("Bolt.Slip_Factor", value)}
                        >
                            <Option value="0.5">0.5</Option>
                            <Option value="0.3">0.3</Option>
                            <Option value="0.2">0.2</Option>
                            <Option value="0.25">0.25</Option>
                            <Option value="0.1">0.1</Option>
                        </Select>
                    </div>
                    
                    <div className="bolt-section description">
                        <h4>Description</h4>
                        <Input.TextArea 
                            rows={8} 
                            value={Bolt_description} 
                            readOnly 
                            style={{ width: '100%' }}
                        />
                    </div>
                    
                    <div>
                        <b>Note: If slip is permitted under the design load design the bolt as a bearing bolt select corresponding bolt grade.</b>
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
                        <h5>Type</h5>
                        <div>
                            <Select style={{ width: '200px', height: '25px',fontSize: '12px' }}
                                value={designPrefInputs && designPrefInputs.bolt_tension_type}
                                onSelect={value => designPrefInputs && setDesignPrefInputs && setDesignPrefInputs({...designPrefInputs, bolt_tension_type: value})}
                            >
                                <Option value="Pretensioned">Pre-tensioned</Option>
                                <Option value="Non pre-tensioned">Non Pre-tensioned</Option>
                            </Select>
                        </div>
                    </div>
                    <div className='input-cont'>
                        <h5>Hole Type</h5>
                        <div>
                            <Select style={{ width: '200px', height: '25px',fontSize: '12px' }}
                                value={designPrefInputs && designPrefInputs.bolt_hole_type}
                                onSelect={value => designPrefInputs && setDesignPrefInputs && setDesignPrefInputs({...designPrefInputs, bolt_hole_type: value})}
                            >
                                <Option value="Standard">Standard</Option>
                                <Option value="0ver-Sized">Over-Sized</Option>
                            </Select>
                        </div>
                    </div>
                    <h4>HSFG Bolt</h4>
                    <div className='input-cont'>
                        <h5>
                            Slip factor, (mu<span style={{ verticalAlign: 'sub', fontSize: 'smaller' }}>f</span>)
                        </h5>
                        <div>
                            <Select style={{ width: '200px', height: '25px',fontSize: '12px' }}
                                value={designPrefInputs && designPrefInputs.bolt_slip_factor}
                                onSelect={value => designPrefInputs && setDesignPrefInputs && setDesignPrefInputs({...designPrefInputs, bolt_slip_factor: value})}
                            >
                                <Option value="0.5">0.5</Option>
                                <Option value="0.3">0.3</Option>
                                <Option value="o.2">0.2</Option>
                                <Option value="o.25">0.25</Option>
                                <Option value="0.1">0.1</Option>
                            </Select>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <div className="sub-container">
                    <h4>Description</h4>
                    <Input.TextArea rows={20} cols={150} value={Bolt_description} readOnly/>
                </div>
            </div>
        </div>
    );
};

export default BoltSectionModal;