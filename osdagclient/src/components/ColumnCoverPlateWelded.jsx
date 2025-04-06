import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import Cookies from 'js-cookie';
import Variable from '../Variable';
import { Table, Modal, Button, Layout, Tabs, Select, Radio, Input, Space, Divider, Dropdown, notification } from 'antd';
import ColumnSectionModal from './ColumnSectionModal';
import WeldSectionModal from './WeldSectionModal';
import DetailingSectionModal from './DetailingSectionModal';
import DesignSectionModal from './DesignSectionModal';
import OutputDock from './OutputDock';
import ConnectorSectionModal from "./ConnectorSectionModal";
import CustomSectionModal from "./CustomSectionModal";
import ThreeRender from './shearConnection/threerender';
import { UserContext } from '../context/UserState';

const { Content } = Layout;
const { TabPane } = Tabs;
const { Option } = Select;

const formItemLayout = {
    labelCol: {
        span: 24,
    },
    wrapperCol: {
        span: 24,
    },
};

// API base URL
const baseUrl = Variable.API_URL;

const ColumnCoverPlateWelded = () => {
    const [loading, setLoading] = useState(false);
    const [resetFlag, setResetFlag] = useState(false);
    const [output, setOutput] = useState(null);
    const [logs, setLogs] = useState([]);
    const [formData, setFormData] = useState({
        "Connectivity": "Column-Column",
        "Connector.Material": "E 250 (Fe 410 W)A",
        "Design.Design_Method": "Limit State Design",
        "Detailing.Corrosive_Influences": "No",
        "Detailing.Gap": "10",
        "Load.Axial": "100",
        "Load.Moment": "10",
        "Load.Shear": "10",
        "Material": "E 250 (Fe 410 W)A",
        "Member.Supported_Section.Designation": "UC 152 x 152 x 30",
        "Member.Supported_Section.Material": "E 250 (Fe 410 W)A",
        "Member.Supporting_Section.Designation": "UC 152 x 152 x 30",
        "Member.Supporting_Section.Material": "E 250 (Fe 410 W)A",
        "Module": "Column Cover Plate Welded",
        "Weld.Fab": "Shop Weld",
        "Weld.Material_Grade_OverWrite": "410",
        "Weld.Size": "6",
        "Connector.Flange_Plate.Thickness_List": ["6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "36", "40", "45", "50", "56", "63"],
        "Connector.Web_Plate.Thickness_List": ["6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "36", "40", "45", "50", "56", "63"],
    });

    // Custom Section modal visibility states
    const [isBeamSectionModalVisible, setIsBeamSectionModalVisible] = useState(false);
    const [isColumnSectionModalVisible, setIsColumnSectionModalVisible] = useState(false);
    const [isWeldSectionModalVisible, setIsWeldSectionModalVisible] = useState(false);
    const [isDetailingSectionModalVisible, setIsDetailingSectionModalVisible] = useState(false);
    const [isDesignSectionModalVisible, setIsDesignSectionModalVisible] = useState(false);
    const [isConnectorSectionModalVisible, setIsConnectorSectionModalVisible] = useState(false);
    const [isCustomSectionModalVisible, setIsCustomSectionModalVisible] = useState(false);
    
    // User context
    const { email } = useContext(UserContext);

    // Create a new session when the component mounts
    useEffect(() => {
        createSession();
    }, []);

    // Create session function
    const createSession = async () => {
        try {
            const response = await axios.get(`${baseUrl}/sessions/create`);
            const sessionId = response.data;
            Cookies.set('column_cover_plate_welded_session', sessionId);
        } catch (error) {
            console.error('Error creating session:', error);
        }
    };

    // Handle form input changes
    const handleInputChange = (name, value) => {
        setFormData({
            ...formData,
            [name]: value,
        });
    };

    // Save input data function
    const saveInputFile = async () => {
        try {
            // First convert the formData to a string
            const formDataString = JSON.stringify(formData, null, 4);

            // Then send it to the backend
            const response = await axios.post(`${baseUrl}/user/saveinput/`, {
                content: formDataString,
                email: email
            });

            notification.success({
                message: 'Success',
                description: 'Input file saved successfully',
            });
        } catch (error) {
            console.error('Error saving input file:', error);
            notification.error({
                message: 'Error',
                description: 'Failed to save input file',
            });
        }
    };

    // Generate output function
    const generateOutput = async () => {
        setLoading(true);
        setOutput(null);
        setLogs([]);

        try {
            const sessionId = Cookies.get('column_cover_plate_welded_session');
            if (!sessionId) {
                throw new Error('No session ID found');
            }

            // Send data for calculation
            const response = await axios.post(`${baseUrl}/calculate-output/Column-Cover-Plate-Welded`, formData, {
                headers: {
                    'Content-Type': 'application/json',
                },
                withCredentials: true,
            });

            // Always display logs if they exist
            if (response.data.logs && response.data.logs.length > 0) {
                setLogs(response.data.logs);
            }

            if (response.data.success) {
                // Set output data if it exists
                if (response.data.data && Object.keys(response.data.data).length > 0) {
                    setOutput(response.data.data);
                    notification.success({
                        message: 'Success',
                        description: 'Output generated successfully',
                    });
                } else {
                    // Handle case where data is empty but success is true (limited functionality mode)
                    notification.info({
                        message: 'Limited Functionality',
                        description: 'The application is running in limited functionality mode',
                    });
                }
            } else {
                notification.warning({
                    message: 'Warning',
                    description: 'Could not generate output. Check the logs for details.',
                });
            }
        } catch (error) {
            console.error('Error generating output:', error);
            let errorMessage = 'An error occurred while generating output';
            
            // Try to extract more specific error message if available
            if (error.response && error.response.data) {
                errorMessage = error.response.data.message || errorMessage;
            }
            
            notification.error({
                message: 'Error',
                description: errorMessage,
            });
            
            // Add error to logs for display
            setLogs([
                { type: 'ERROR', msg: errorMessage }
            ]);
        } finally {
            setLoading(false);
        }
    };

    // Reset form function
    const resetForm = () => {
        setFormData({
            "Connectivity": "Column-Column",
            "Connector.Material": "E 250 (Fe 410 W)A",
            "Design.Design_Method": "Limit State Design",
            "Detailing.Corrosive_Influences": "No",
            "Detailing.Gap": "10",
            "Load.Axial": "100",
            "Load.Moment": "10",
            "Load.Shear": "10",
            "Material": "E 250 (Fe 410 W)A",
            "Member.Supported_Section.Designation": "UC 152 x 152 x 30",
            "Member.Supported_Section.Material": "E 250 (Fe 410 W)A",
            "Member.Supporting_Section.Designation": "UC 152 x 152 x 30",
            "Member.Supporting_Section.Material": "E 250 (Fe 410 W)A",
            "Module": "Column Cover Plate Welded",
            "Weld.Fab": "Shop Weld",
            "Weld.Material_Grade_OverWrite": "410",
            "Weld.Size": "6",
            "Connector.Flange_Plate.Thickness_List": ["6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "36", "40", "45", "50", "56", "63"],
            "Connector.Web_Plate.Thickness_List": ["6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "36", "40", "45", "50", "56", "63"],
        });
        setOutput(null);
        setLogs([]);
        setResetFlag(!resetFlag);
    };

    // Generate CAD model
    const generateCAD = async (section) => {
        try {
            const sessionId = Cookies.get('column_cover_plate_welded_session');
            await axios.post(`${baseUrl}/design/cad`, {
                input_values: formData,
                section: section,
                session: sessionId
            });
            
            notification.success({
                message: 'Success',
                description: `CAD model for ${section} generated successfully`,
            });
        } catch (error) {
            console.error('Error generating CAD model:', error);
            notification.error({
                message: 'Error',
                description: 'Failed to generate CAD model',
            });
        }
    };

    // Generate report
    const generateReport = async () => {
        try {
            const metadata = {
                ProjectTitle: "Column Cover Plate Welded Connection",
                Subtitle: "Column to Column Splice",
                JobNumber: "1",
                Client: "Osdag",
                CompanyName: "Your Company",
                Designer: "Designer",
                ProfileSummary: {
                    CompanyName: "Your Company",
                    CompanyLogo: "",
                    Group: "Your Team",
                    Designer: "Designer"
                }
            };

            const response = await axios.post(`${baseUrl}/generate-report`, {
                metadata: metadata
            }, {
                withCredentials: true
            });

            const reportId = response.data.report_id;

            // Open PDF in a new window
            window.open(`${baseUrl}/getPDF?report_id=${reportId}`, '_blank');
        } catch (error) {
            console.error('Error generating report:', error);
            notification.error({
                message: 'Error',
                description: 'Failed to generate report',
            });
        }
    };

    return (
        <Layout className='layout'>
            <div className='title'>Column Cover Plate Welded Connection</div>
            <Layout className='mainContentLayout'>
                <Content className='mainContent shear-connection'>
                    <div className='inputContainer'>
                        <Tabs defaultActiveKey='1'>
                            <TabPane tab='Input' key='1'>
                                <Tabs tabPosition='left' defaultActiveKey='1' className="nested-tabs">
                                    <TabPane tab='Column Section' key='1' className="section-tab">
                                        <div className='section-component'>
                                            <div className='section'>
                                                <div className='section-label'> Select Column Section</div>
                                                <Space>
                                                    <Input
                                                        className='input-section'
                                                        value={formData["Member.Supporting_Section.Designation"]}
                                                        style={{ width: 180 }}
                                                        readOnly
                                                    />
                                                    <Button className='section-button' onClick={() => setIsColumnSectionModalVisible(true)}>Select</Button>
                                                </Space>
                                            </div>
                                            <div className='section'>
                                                <div className='section-label'>Material</div>
                                                <Select
                                                    value={formData["Member.Supporting_Section.Material"]}
                                                    className='select-section'
                                                    style={{ width: 180 }}
                                                    onChange={(value) => {
                                                        handleInputChange("Member.Supporting_Section.Material", value);
                                                        handleInputChange("Member.Supported_Section.Material", value);
                                                        handleInputChange("Material", value);
                                                        handleInputChange("Connector.Material", value);
                                                    }}
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
                                                    <Option value="Custom">Custom</Option>
                                                </Select>
                                                {formData["Member.Supporting_Section.Material"] === "Custom" && (
                                                    <Button
                                                        className='custom-material-button'
                                                        onClick={() => setIsCustomSectionModalVisible(true)}
                                                    >
                                                        Custom Material
                                                    </Button>
                                                )}
                                            </div>
                                        </div>
                                    </TabPane>
                                    <TabPane tab='Connector' key='2' className="section-tab">
                                        <div className='section-component'>
                                            <div className='section'>
                                                <div className='section-label'>Material</div>
                                                <Select
                                                    value={formData["Connector.Material"]}
                                                    className='select-section'
                                                    style={{ width: 180 }}
                                                    onChange={(value) => handleInputChange("Connector.Material", value)}
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
                                            <Button 
                                                className='connector-button' 
                                                onClick={() => setIsConnectorSectionModalVisible(true)}>
                                                Flange & Web Plate
                                            </Button>
                                        </div>
                                    </TabPane>
                                    <TabPane tab='Weld' key='3' className="section-tab">
                                        <div className='section-component'>
                                            <div className='section'>
                                                <div className='section-label'>Weld Size (mm)</div>
                                                <Input
                                                    className='input-section'
                                                    value={formData["Weld.Size"]}
                                                    onChange={(e) => handleInputChange("Weld.Size", e.target.value)}
                                                    style={{ width: 180 }}
                                                />
                                            </div>
                                            <Button 
                                                className='weld-button' 
                                                onClick={() => setIsWeldSectionModalVisible(true)}>
                                                Weld Properties
                                            </Button>
                                        </div>
                                    </TabPane>
                                    <TabPane tab='Detailing' key='4' className="section-tab">
                                        <Button 
                                            className='detailing-button' 
                                            onClick={() => setIsDetailingSectionModalVisible(true)}>
                                            Detailing
                                        </Button>
                                    </TabPane>
                                    <TabPane tab='Design' key='5' className="section-tab">
                                        <Button 
                                            className='design-button' 
                                            onClick={() => setIsDesignSectionModalVisible(true)}>
                                            Design Method
                                        </Button>
                                    </TabPane>
                                    <TabPane tab='Load' key='6' className="section-tab">
                                        <div className='section-component'>
                                            <div className='section'>
                                                <div className='section-label'>Factored shear force (kN)</div>
                                                <Input
                                                    className='input-section'
                                                    value={formData["Load.Shear"]}
                                                    onChange={(e) => handleInputChange("Load.Shear", e.target.value)}
                                                    style={{ width: 180 }}
                                                />
                                            </div>
                                            <div className='section'>
                                                <div className='section-label'>Factored axial force (kN)</div>
                                                <Input
                                                    className='input-section'
                                                    value={formData["Load.Axial"]}
                                                    onChange={(e) => handleInputChange("Load.Axial", e.target.value)}
                                                    style={{ width: 180 }}
                                                />
                                            </div>
                                            <div className='section'>
                                                <div className='section-label'>Factored moment (kNm)</div>
                                                <Input
                                                    className='input-section'
                                                    value={formData["Load.Moment"]}
                                                    onChange={(e) => handleInputChange("Load.Moment", e.target.value)}
                                                    style={{ width: 180 }}
                                                />
                                            </div>
                                        </div>
                                    </TabPane>
                                </Tabs>
                            </TabPane>
                            <TabPane tab='Output' key='2'>
                                <div className='design-button-container'>
                                    <Button
                                        className='design-btn'
                                        onClick={generateOutput}
                                        loading={loading}
                                    >
                                        Design
                                    </Button>
                                    <Button
                                        className='reset-btn'
                                        onClick={resetForm}
                                    >
                                        Reset
                                    </Button>
                                </div>
                                <div className='output-container'>
                                    {output ? (
                                        <OutputDock output={output} />
                                    ) : (
                                        <div className="no-output-message">
                                            <p>Click the Design button to generate output</p>
                                            {logs && logs.length > 0 && logs.some(log => log.type === 'WARNING') && (
                                                <p className="warning-message">Some features may be limited due to missing dependencies</p>
                                            )}
                                        </div>
                                    )}
                                </div>
                                {logs && logs.length > 0 && (
                                    <div className='logs-container'>
                                        <h3>Logs</h3>
                                        <div className='logs'>
                                            {logs.map((log, index) => (
                                                <div key={index} className={`log-entry ${log.type && log.type.toLowerCase()}`}>
                                                    {log.msg}
                                                </div>
                                            ))}
                                        </div>
                                    </div>
                                )}
                            </TabPane>
                            <TabPane tab='3D View' key='3'>
                                <div className='viewer-container'>
                                    <ThreeRender resetFlag={resetFlag} />
                                </div>
                            </TabPane>
                        </Tabs>
                    </div>
                    <div className='bottom-action-buttons'>
                        <Button className='save-btn' onClick={saveInputFile}>
                            Save Input
                        </Button>
                        <Button className='cad-btn' onClick={() => generateCAD('Model')}>
                            CAD Model
                        </Button>
                        <Button className='report-btn' onClick={generateReport}>
                            Report
                        </Button>
                    </div>
                </Content>
            </Layout>

            {/* Column Section Modal */}
            <ColumnSectionModal
                visible={isColumnSectionModalVisible}
                onClose={() => setIsColumnSectionModalVisible(false)}
                onSelectSection={(section) => {
                    handleInputChange("Member.Supporting_Section.Designation", section);
                    handleInputChange("Member.Supported_Section.Designation", section);
                    setIsColumnSectionModalVisible(false);
                }}
            />

            {/* Weld Section Modal */}
            <WeldSectionModal
                visible={isWeldSectionModalVisible}
                onClose={() => setIsWeldSectionModalVisible(false)}
                onSave={(weldValues) => {
                    handleInputChange("Weld.Fab", weldValues.fabrication);
                    handleInputChange("Weld.Material_Grade_OverWrite", weldValues.materialGradeOverwrite);
                    setIsWeldSectionModalVisible(false);
                }}
                initialValues={{
                    fabrication: formData["Weld.Fab"],
                    materialGradeOverwrite: formData["Weld.Material_Grade_OverWrite"]
                }}
            />

            {/* Detailing Section Modal */}
            <DetailingSectionModal
                visible={isDetailingSectionModalVisible}
                onClose={() => setIsDetailingSectionModalVisible(false)}
                onSave={(detailingValues) => {
                    handleInputChange("Detailing.Corrosive_Influences", detailingValues.corrosiveInfluence);
                    handleInputChange("Detailing.Gap", detailingValues.gap);
                    setIsDetailingSectionModalVisible(false);
                }}
                initialValues={{
                    corrosiveInfluence: formData["Detailing.Corrosive_Influences"],
                    gap: formData["Detailing.Gap"]
                }}
            />

            {/* Design Section Modal */}
            <DesignSectionModal
                visible={isDesignSectionModalVisible}
                onClose={() => setIsDesignSectionModalVisible(false)}
                onSave={(designValues) => {
                    handleInputChange("Design.Design_Method", designValues.designMethod);
                    setIsDesignSectionModalVisible(false);
                }}
                initialValues={{
                    designMethod: formData["Design.Design_Method"]
                }}
            />

            {/* Connector Section Modal */}
            <ConnectorSectionModal
                visible={isConnectorSectionModalVisible}
                onCancel={() => setIsConnectorSectionModalVisible(false)}
                onOk={(values) => {
                    for (const [key, value] of Object.entries(values)) {
                        handleInputChange(key, value);
                    }
                    setIsConnectorSectionModalVisible(false);
                }}
                initialValues={{
                    "Connector.Flange_Plate.Thickness_List": formData["Connector.Flange_Plate.Thickness_List"],
                    "Connector.Web_Plate.Thickness_List": formData["Connector.Web_Plate.Thickness_List"],
                    "Connector.Material": formData["Connector.Material"],
                }}
                resetFlag={resetFlag}
                moduleType="column_cover_plate"
            />

            {/* Custom Section Modal */}
            <CustomSectionModal
                visible={isCustomSectionModalVisible}
                onClose={() => setIsCustomSectionModalVisible(false)}
                onSave={(customValues) => {
                    // Handle custom material values
                    setIsCustomSectionModalVisible(false);
                }}
                initialValues={{
                    // Add any initial values for custom section
                }}
            />
        </Layout>
    );
};

export default ColumnCoverPlateWelded; 