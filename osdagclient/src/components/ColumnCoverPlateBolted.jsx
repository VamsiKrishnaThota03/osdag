import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import Cookies from 'js-cookie';
import Variable from '../Variable';
import { Table, Modal, Button, Layout, Menu, Select, Radio, Input, Space, Divider, Dropdown, notification, Checkbox, Row, Col } from 'antd';
import ColumnSectionModal from './ColumnSectionModal';
import BoltSectionModal from './BoltSectionModal';
import WeldSectionModal from './WeldSectionModal';
import DetailingSectionModal from './DetailingSectionModal';
import DesignSectionModal from './DesignSectionModal';
import OutputDock from './OutputDock';
import ConnectorSectionModal from "./ConnectorSectionModal";
import CustomSectionModal from "./CustomSectionModal";
import ThreeRender from './shearConnection/threerender';
import { UserContext } from '../context/UserState';
import { FileTextOutlined, SaveOutlined, FileOutlined, EditOutlined, DatabaseOutlined, QuestionOutlined, SettingOutlined, DownOutlined } from '@ant-design/icons';
import ErrorBoundary from './ErrorBoundary';

const { Content, Header } = Layout;
const { Option } = Select;

// Style definitions
const styles = {
    layout: { 
        height: '100vh', 
        display: 'flex', 
        flexDirection: 'column',
        overflow: 'hidden',
        width: '100%'
    },
    header: { 
        height: '40px', 
        lineHeight: '40px', 
        padding: '0 20px', 
        background: '#001529',
        width: '100%'
    },
    title: { 
        textAlign: 'center', 
        padding: '5px 0', 
        fontSize: '18px', 
        fontWeight: 'bold',
        borderBottom: '1px solid #ddd',
        width: '100%'
    },
    mainContent: { 
        flex: 1, 
        padding: '5px', 
        overflow: 'hidden',
        display: 'flex',
        width: '100%'
    },
    column: {
        height: '100%',
        flex: 1,
        padding: '0 2px'
    },
    contentSection: {
        height: '100%', 
        border: '1px solid #ddd', 
        borderRadius: '4px', 
        display: 'flex',
        flexDirection: 'column'
    },
    sectionTitle: {
        padding: '8px', 
        borderBottom: '1px solid #ddd', 
        background: '#f5f5f5', 
        fontWeight: 'bold',
        fontSize: '14px'
    },
    sectionContent: {
        padding: '8px',
        flex: 1,
        overflow: 'auto'
    },
    viewerContainer: {
        flex: 1,
        minHeight: '280px',
        position: 'relative'
    },
    logConsole: {
        marginTop: '5px', 
        maxHeight: '80px', 
        overflow: 'auto', 
        border: '1px solid #ddd', 
        padding: '3px'
    },
    actionButtons: {
        display: 'flex',
        justifyContent: 'space-between',
        marginTop: '20px'
    },
    inputSection: {
        marginBottom: '15px',
        border: '1px solid #f0f0f0',
        borderRadius: '4px',
        padding: '10px'
    },
    sectionHeader: {
        fontWeight: 'bold',
        borderBottom: '1px solid #f0f0f0',
        marginBottom: '10px',
        paddingBottom: '5px'
    },
    sectionComponent: {
        display: 'flex',
        flexDirection: 'column',
        gap: '10px'
    },
    section: {
        marginBottom: '10px'
    },
    sectionLabel: {
        marginBottom: '5px'
    },
    outputContainer: {
        padding: '2px'
    },
    outputSection: {
        marginBottom: '10px'
    },
    outputSectionHeader: {
        fontWeight: 'bold',
        borderBottom: '1px solid #f0f0f0',
        marginBottom: '5px',
        paddingBottom: '3px',
        marginTop: '10px',
        fontSize: '14px'
    },
    outputField: {
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        padding: '3px 0',
        borderBottom: '1px dashed #f0f0f0'
    },
    outputLabel: {
        fontWeight: '500',
        fontSize: '13px',
        whiteSpace: 'nowrap',
        marginRight: '5px'
    },
    outputValue: {
        // Added to ensure text values are visible
        color: '#000000'
    },
    outputButtons: {
        display: 'flex',
        gap: '10px',
        flexWrap: 'wrap',
        marginTop: '10px'
    },
    bottomActionButtons: {
        display: 'flex',
        justifyContent: 'space-between',
        marginTop: '20px'
    },
    noOutputMessage: {
        textAlign: 'center',
        marginTop: '30px'
    },
    warningMessage: {
        color: '#faad14'
    },
    logsContainer: {
        marginTop: '20px'
    },
    logs: {
        maxHeight: '200px',
        overflow: 'auto',
        border: '1px solid #ddd',
        padding: '5px'
    },
    logEntry: {
        padding: '2px 0'
    },
    viewControls: {
        marginBottom: '10px',
        display: 'flex',
        flexDirection: 'column',
        gap: '10px'
    },
    viewButtons: {
        display: 'flex',
        gap: '5px'
    },
    axisToggles: {
        margin: '10px 0',
        display: 'flex',
        gap: '10px'
    },
    modelToggles: {
        display: 'flex',
        gap: '10px'
    }
};

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

const ColumnCoverPlateBolted = () => {
    const [loading, setLoading] = useState(false);
    const [resetFlag, setResetFlag] = useState(false);
    const [output, setOutput] = useState(null);
    const [logs, setLogs] = useState([]);
    const [modelGenerated, setModelGenerated] = useState(false);
    const [formData, setFormData] = useState({
        "Bolt.Bolt_Hole_Type": "Standard",
        "Bolt.Diameter": ["12", "16", "20", "24", "30"],
        "Bolt.Grade": ["4.6", "4.8", "5.6", "6.8", "8.8"],
        "Bolt.Slip_Factor": "0.3",
        "Bolt.TensionType": "Non Pre-tensioned",
        "Bolt.Type": "Bearing Bolt",
        "Connectivity": "Column-Column",
        "Connector.Material": "E 250 (Fe 410 W)A",
        "Design.Design_Method": "Limit State Design",
        "Detailing.Corrosive_Influences": "No",
        "Detailing.Edge_type": "Rolled",
        "Detailing.Gap": "10",
        "Load.Axial": "100",
        "Load.Moment": "10",
        "Load.Shear": "10",
        "Material": "E 250 (Fe 410 W)A",
        "Member.Supported_Section.Designation": "UC 152 x 152 x 30",
        "Member.Supported_Section.Material": "E 250 (Fe 410 W)A",
        "Member.Supporting_Section.Designation": "UC 152 x 152 x 30",
        "Member.Supporting_Section.Material": "E 250 (Fe 410 W)A",
        "Module": "Column Cover Plate Bolted",
        "Weld.Fab": "Shop Weld",
        "Weld.Material_Grade_OverWrite": "410",
        "Connector.Flange_Plate.Thickness_List": ["6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "36", "40", "45", "50", "56", "63"],
        "Connector.Web_Plate.Thickness_List": ["6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "36", "40", "45", "50", "56", "63"],
    });

    // Custom Section modal visibility states
    const [isBeamSectionModalVisible, setIsBeamSectionModalVisible] = useState(false);
    const [isColumnSectionModalVisible, setIsColumnSectionModalVisible] = useState(false);
    const [isBoltSectionModalVisible, setIsBoltSectionModalVisible] = useState(false);
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
            Cookies.set('column_cover_plate_bolted_session', sessionId);
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
        setModelGenerated(false);

        try {
            const sessionId = Cookies.get('column_cover_plate_bolted_session');
            if (!sessionId) {
                throw new Error('No session ID found');
            }

            // Send data for calculation
            const response = await axios.post(`${baseUrl}/calculate-output/Column-Cover-Plate-Bolted`, formData, {
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
                    
                    // Check if model was generated or can be generated
                    const canShowModel = !response.data.logs.some(log => 
                        log.type === 'ERROR' && 
                        (log.msg.includes('3D') || log.msg.includes('model') || log.msg.includes('visualization'))
                    );
                    
                    if (canShowModel) {
                        // Try to generate 3D model
                        try {
                            await generateCAD("complete");
                            setModelGenerated(true);
                        } catch (modelError) {
                            console.error('Error generating 3D model:', modelError);
                            setLogs(prevLogs => [
                                ...prevLogs, 
                                { type: 'WARNING', msg: 'Failed to generate 3D model. The visualization may not be available.' }
                            ]);
                        }
                    } else {
                        console.log('3D model generation skipped due to errors in response logs');
                        setLogs(prevLogs => [
                            ...prevLogs, 
                            { type: 'INFO', msg: '3D visualization is not available for this design.' }
                        ]);
                    }
                    
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
            "Bolt.Bolt_Hole_Type": "Standard",
            "Bolt.Diameter": ["12", "16", "20", "24", "30"],
            "Bolt.Grade": ["4.6", "4.8", "5.6", "6.8", "8.8"],
            "Bolt.Slip_Factor": "0.3",
            "Bolt.TensionType": "Non Pre-tensioned",
            "Bolt.Type": "Bearing Bolt",
            "Connectivity": "Column-Column",
            "Connector.Material": "E 250 (Fe 410 W)A",
            "Design.Design_Method": "Limit State Design",
            "Detailing.Corrosive_Influences": "No",
            "Detailing.Edge_type": "Rolled",
            "Detailing.Gap": "10",
            "Load.Axial": "100",
            "Load.Moment": "10",
            "Load.Shear": "10",
            "Material": "E 250 (Fe 410 W)A",
            "Member.Supported_Section.Designation": "UC 152 x 152 x 30",
            "Member.Supported_Section.Material": "E 250 (Fe 410 W)A",
            "Member.Supporting_Section.Designation": "UC 152 x 152 x 30",
            "Member.Supporting_Section.Material": "E 250 (Fe 410 W)A",
            "Module": "Column Cover Plate Bolted",
            "Weld.Fab": "Shop Weld",
            "Weld.Material_Grade_OverWrite": "410",
            "Connector.Flange_Plate.Thickness_List": ["6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "36", "40", "45", "50", "56", "63"],
            "Connector.Web_Plate.Thickness_List": ["6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32", "36", "40", "45", "50", "56", "63"],
        });
        setOutput(null);
        setLogs([]);
        setModelGenerated(false);
        setResetFlag(!resetFlag);
    };

    // Generate CAD model
    const generateCAD = async (section) => {
        try {
            const sessionId = Cookies.get('column_cover_plate_bolted_session');
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
                ProjectTitle: "Column Cover Plate Bolted Connection",
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

    // Define the file menu handlers
    const handleFileMenuClick = ({ key }) => {
        switch(key) {
            case 'load-input':
                // Handle load input action
                notification.info({
                    message: 'Load Input',
                    description: 'Load Input functionality will be implemented here (⌘L)'
                });
                break;
            case 'save-input':
                saveInputFile();
                break;
            case 'save-log':
                // Handle save log messages action
                notification.info({
                    message: 'Save Log Messages',
                    description: 'Save Log Messages functionality will be implemented here (⌥⌘M)'
                });
                break;
            case 'create-report':
                generateReport();
                break;
            case 'save-3d':
                // Handle save 3D model action
                notification.info({
                    message: 'Save 3D Model',
                    description: 'Save 3D Model functionality will be implemented here (⌥⌘3)'
                });
                break;
            case 'save-cad':
                // Handle save CAD image action
                notification.info({
                    message: 'Save CAD Image',
                    description: 'Save CAD Image functionality will be implemented here (⌥⌘I)'
                });
                break;
            case 'save-front':
                // Handle save front view action
                notification.info({
                    message: 'Save Front View',
                    description: 'Save Front View functionality will be implemented here (⌥⇧⌘F)'
                });
                break;
            case 'save-top':
                // Handle save top view action
                notification.info({
                    message: 'Save Top View',
                    description: 'Save Top View functionality will be implemented here (⌥⇧⌘T)'
                });
                break;
            case 'save-side':
                // Handle save side view action
                notification.info({
                    message: 'Save Side View',
                    description: 'Save Side View functionality will be implemented here (⌥⇧⌘S)'
                });
                break;
            case 'quit':
                // Handle quit action
                notification.info({
                    message: 'Quit',
                    description: 'Quit functionality will be implemented here (⇧⌘Q)'
                });
                break;
            default:
                break;
        }
    };

    // Add handlers for other menu items
    const handleEditMenuClick = ({ key }) => {
        switch(key) {
            case 'design-preferences':
                notification.info({
                    message: 'Design Preferences',
                    description: 'Design Preferences functionality will be implemented here'
                });
                break;
            case 'section-modeler':
                notification.info({
                    message: 'Section Modeler',
                    description: 'Section Modeler functionality will be implemented here'
                });
                break;
            default:
                break;
        }
    };

    const handleGraphicsMenuClick = ({ key }) => {
        switch(key) {
            case 'zoom-in':
                notification.info({
                    message: 'Zoom In',
                    description: 'Zoom In functionality will be implemented here (⌘I)'
                });
                break;
            case 'zoom-out':
                notification.info({
                    message: 'Zoom Out',
                    description: 'Zoom Out functionality will be implemented here (⌘O)'
                });
                break;
            case 'pan':
                notification.info({
                    message: 'Pan',
                    description: 'Pan functionality will be implemented here (⌘P)'
                });
                break;
            case 'rotate':
                notification.info({
                    message: 'Rotate 3D Model',
                    description: 'Rotate 3D Model functionality will be implemented here (⌘R)'
                });
                break;
            case 'model':
                notification.info({
                    message: 'Model',
                    description: 'Model display toggle functionality will be implemented here'
                });
                break;
            case 'column':
                notification.info({
                    message: 'Column',
                    description: 'Column display toggle functionality will be implemented here'
                });
                break;
            case 'cover-plate':
                notification.info({
                    message: 'Cover Plate',
                    description: 'Cover Plate display toggle functionality will be implemented here'
                });
                break;
            case 'background':
                notification.info({
                    message: 'Change Background',
                    description: 'Change Background functionality will be implemented here'
                });
                break;
            default:
                break;
        }
    };

    const handleDatabaseMenuClick = ({ key }) => {
        switch(key) {
            case 'download-column':
                notification.info({
                    message: 'Download Column Database',
                    description: 'Column database download functionality will be implemented here'
                });
                break;
            case 'download-beam':
                notification.info({
                    message: 'Download Beam Database',
                    description: 'Beam database download functionality will be implemented here'
                });
                break;
            case 'download-angle':
                notification.info({
                    message: 'Download Angle Database',
                    description: 'Angle database download functionality will be implemented here'
                });
                break;
            case 'download-channel':
                notification.info({
                    message: 'Download Channel Database',
                    description: 'Channel database download functionality will be implemented here'
                });
                break;
            case 'reset':
                notification.info({
                    message: 'Reset',
                    description: 'Reset functionality will be implemented here'
                });
                break;
            default:
                break;
        }
    };

    const handleHelpMenuClick = ({ key }) => {
        switch(key) {
            case 'tutorials':
                notification.info({
                    message: 'Video Tutorials',
                    description: 'Video Tutorials functionality will be implemented here'
                });
                break;
            case 'examples':
                notification.info({
                    message: 'Design Examples',
                    description: 'Design Examples functionality will be implemented here'
                });
                break;
            case 'question':
                notification.info({
                    message: 'Ask Us a Question',
                    description: 'Ask Us a Question functionality will be implemented here'
                });
                break;
            case 'about':
                notification.info({
                    message: 'About Osdag',
                    description: 'About Osdag functionality will be implemented here'
                });
                break;
            case 'update':
                notification.info({
                    message: 'Check For Update',
                    description: 'Check For Update functionality will be implemented here'
                });
                break;
            default:
                break;
        }
    };

    // Create the file menu
    const fileMenu = (
        <Menu onClick={handleFileMenuClick}>
            <Menu.Item key="load-input">
                Load Input <span style={{ float: 'right', opacity: 0.7 }}>⌘L</span>
            </Menu.Item>
            <Menu.Item key="save-input">
                Save Input <span style={{ float: 'right', opacity: 0.7 }}>⌘S</span>
            </Menu.Item>
            <Menu.Divider />
            <Menu.Item key="save-log">
                Save Log Messages <span style={{ float: 'right', opacity: 0.7 }}>⌥⌘M</span>
            </Menu.Item>
            <Menu.Item key="create-report">
                Create Design Report <span style={{ float: 'right', opacity: 0.7 }}>⌥⌘C</span>
            </Menu.Item>
            <Menu.Divider />
            <Menu.Item key="save-3d">
                Save 3D Model <span style={{ float: 'right', opacity: 0.7 }}>⌥⌘3</span>
            </Menu.Item>
            <Menu.Item key="save-cad">
                Save CAD Image <span style={{ float: 'right', opacity: 0.7 }}>⌥⌘I</span>
            </Menu.Item>
            <Menu.Item key="save-front">
                Save Front View <span style={{ float: 'right', opacity: 0.7 }}>⌥⇧⌘F</span>
            </Menu.Item>
            <Menu.Item key="save-top">
                Save Top View <span style={{ float: 'right', opacity: 0.7 }}>⌥⇧⌘T</span>
            </Menu.Item>
            <Menu.Item key="save-side">
                Save Side View <span style={{ float: 'right', opacity: 0.7 }}>⌥⇧⌘S</span>
            </Menu.Item>
            <Menu.Divider />
            <Menu.Item key="quit">
                Quit <span style={{ float: 'right', opacity: 0.7 }}>⇧⌘Q</span>
            </Menu.Item>
        </Menu>
    );

    // Create the edit menu
    const editMenu = (
        <Menu onClick={handleEditMenuClick}>
            <Menu.Item key="design-preferences">
                Design Preferences
            </Menu.Item>
            <Menu.Item key="section-modeler">
                Section Modeler
            </Menu.Item>
        </Menu>
    );

    // Create the graphics menu
    const graphicsMenu = (
        <Menu onClick={handleGraphicsMenuClick}>
            <Menu.Item key="zoom-in">
                Zoom In <span style={{ float: 'right', opacity: 0.7 }}>⌘I</span>
            </Menu.Item>
            <Menu.Item key="zoom-out">
                Zoom Out <span style={{ float: 'right', opacity: 0.7 }}>⌘O</span>
            </Menu.Item>
            <Menu.Item key="pan">
                Pan <span style={{ float: 'right', opacity: 0.7 }}>⌘P</span>
            </Menu.Item>
            <Menu.Item key="rotate">
                Rotate 3D Model <span style={{ float: 'right', opacity: 0.7 }}>⌘R</span>
            </Menu.Item>
            <Menu.Divider />
            <Menu.Item key="model">
                Model
            </Menu.Item>
            <Menu.Item key="column">
                Column
            </Menu.Item>
            <Menu.Item key="cover-plate">
                Cover Plate
            </Menu.Item>
            <Menu.Divider />
            <Menu.Item key="background">
                Change Background
            </Menu.Item>
        </Menu>
    );

    // Create the database menu
    const downloadSubMenu = (
        <Menu onClick={handleDatabaseMenuClick}>
            <Menu.Item key="download-column">Column</Menu.Item>
            <Menu.Item key="download-beam">Beam</Menu.Item>
            <Menu.Item key="download-angle">Angle</Menu.Item>
            <Menu.Item key="download-channel">Channel</Menu.Item>
        </Menu>
    );

    const databaseMenu = (
        <Menu onClick={handleDatabaseMenuClick}>
            <Menu.SubMenu key="download" title="Download" popupClassName="database-submenu">
                <Menu.Item key="download-column">Column</Menu.Item>
                <Menu.Item key="download-beam">Beam</Menu.Item>
                <Menu.Item key="download-angle">Angle</Menu.Item>
                <Menu.Item key="download-channel">Channel</Menu.Item>
            </Menu.SubMenu>
            <Menu.Item key="reset">Reset</Menu.Item>
        </Menu>
    );

    // Create the help menu
    const helpMenu = (
        <Menu onClick={handleHelpMenuClick}>
            <Menu.Item key="tutorials">
                Video Tutorials
            </Menu.Item>
            <Menu.Item key="examples">
                Design Examples
            </Menu.Item>
            <Menu.Item key="question">
                Ask Us a Question
            </Menu.Item>
            <Menu.Item key="about">
                About Osdag
            </Menu.Item>
            <Menu.Item key="update">
                Check For Update
            </Menu.Item>
        </Menu>
    );

    return (
        <Layout style={{ 
            height: '100vh', 
            width: '100vw', 
            margin: 0,
            padding: 0,
            display: 'flex',
            flexDirection: 'column',
            overflow: 'hidden'
        }}>
            {/* Top Navigation Bar */}
            <Header style={{ 
                height: '40px',
                width: '100%',
                padding: '0 20px',
                margin: 0,
                lineHeight: '40px',
                background: '#001529'
            }}>
                <Menu mode="horizontal" theme="dark" style={{ lineHeight: '40px' }}>
                    <Menu.Item key="file" style={{ paddingRight: '30px' }}>
                        <Dropdown overlay={fileMenu} trigger={['click']}>
                            <span style={{ cursor: 'pointer', display: 'inline-flex', alignItems: 'center' }}>
                                <FileOutlined style={{ marginRight: '5px' }} />
                                File <DownOutlined style={{ fontSize: '10px', marginLeft: '5px' }} />
                            </span>
                        </Dropdown>
                    </Menu.Item>
                    <Menu.Item key="edit" style={{ paddingRight: '30px' }}>
                        <Dropdown overlay={editMenu} trigger={['click']}>
                            <span style={{ cursor: 'pointer', display: 'inline-flex', alignItems: 'center' }}>
                                <EditOutlined style={{ marginRight: '5px' }} />
                                Edit <DownOutlined style={{ fontSize: '10px', marginLeft: '5px' }} />
                            </span>
                        </Dropdown>
                    </Menu.Item>
                    <Menu.Item key="graphics" style={{ paddingRight: '30px' }}>
                        <Dropdown overlay={graphicsMenu} trigger={['click']}>
                            <span style={{ cursor: 'pointer', display: 'inline-flex', alignItems: 'center' }}>
                                <SettingOutlined style={{ marginRight: '5px' }} />
                                Graphics <DownOutlined style={{ fontSize: '10px', marginLeft: '5px' }} />
                            </span>
                        </Dropdown>
                    </Menu.Item>
                    <Menu.Item key="database" style={{ paddingRight: '30px' }}>
                        <Dropdown overlay={databaseMenu} trigger={['click']}>
                            <span style={{ cursor: 'pointer', display: 'inline-flex', alignItems: 'center' }}>
                                <DatabaseOutlined style={{ marginRight: '5px' }} />
                                Database <DownOutlined style={{ fontSize: '10px', marginLeft: '5px' }} />
                            </span>
                        </Dropdown>
                    </Menu.Item>
                    <Menu.Item key="help" style={{ paddingRight: '30px' }}>
                        <Dropdown overlay={helpMenu} trigger={['click']}>
                            <span style={{ cursor: 'pointer', display: 'inline-flex', alignItems: 'center' }}>
                                <QuestionOutlined style={{ marginRight: '5px' }} />
                                Help <DownOutlined style={{ fontSize: '10px', marginLeft: '5px' }} />
                            </span>
                        </Dropdown>
                    </Menu.Item>
                </Menu>
            </Header>

            {/* Title Bar */}
            <div style={{ 
                width: '100%',
                textAlign: 'center',
                padding: '5px 0',
                margin: 0,
                fontSize: '18px',
                fontWeight: 'bold',
                borderBottom: '1px solid #ddd'
            }}>
                Column Cover Plate Bolted Connection
            </div>

            {/* Main Content */}
            <Content style={{ 
                flex: 1,
                width: '100%',
                padding: 0,
                margin: 0,
                overflow: 'hidden'
            }}>
                <Row style={{ 
                    width: '100%', 
                    height: '100%', 
                    margin: 0, 
                    padding: 0,
                    display: 'flex'
                }}>
                    {/* Input Column - exactly 1/3 width */}
                    <Col style={{ flex: '1 1 33.333%', height: '100%', padding: '0 1px' }}>
                        <div style={styles.contentSection}>
                            <div style={styles.sectionTitle}>Input</div>
                            <div style={styles.sectionContent}>
                                <div style={{ width: '100%' }}>
                                    {/* Connecting Members Section */}
                                    <div style={{ 
                                        marginBottom: '15px',
                                        border: '1px solid #f0f0f0',
                                        borderRadius: '4px',
                                        padding: '10px'
                                    }}>
                                        <div style={{ 
                                            fontWeight: 'bold',
                                            borderBottom: '1px solid #f0f0f0',
                                            marginBottom: '10px',
                                            paddingBottom: '5px'
                                        }}>
                                            Connecting Members
                                        </div>
                                        <div style={{ 
                                            display: 'flex',
                                            flexDirection: 'column',
                                            gap: '10px'
                                        }}>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Section Designation</div>
                                                <Select
                                                        value={formData["Member.Supporting_Section.Designation"]}
                                                    style={{ width: '100%' }}
                                                    onChange={(value) => {
                                                        handleInputChange("Member.Supporting_Section.Designation", value);
                                                        handleInputChange("Member.Supported_Section.Designation", value);
                                                    }}
                                                    defaultValue="Select Section"
                                                >
                                                    <Option value="Select Section">Select Section</Option>
                                                    <Option value="HB 150">HB 150</Option>
                                                    <Option value="HB 150*">HB 150*</Option>
                                                    <Option value="HB 200">HB 200</Option>
                                                </Select>
                                            </div>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Material</div>
                                                <Select
                                                    defaultValue="E 165 (Fe 290)"
                                                    value={formData["Member.Supporting_Section.Material"]}
                                                    style={{ width: '100%' }}
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
                                                        style={{ marginTop: '5px' }}
                                                        onClick={() => setIsCustomSectionModalVisible(true)}
                                                    >
                                                        Custom Material
                                                    </Button>
                                                )}
                                            </div>
                                        </div>
                                    </div>

                                    {/* Factored Loads Section */}
                                    <div style={{ 
                                        marginBottom: '15px',
                                        border: '1px solid #f0f0f0',
                                        borderRadius: '4px',
                                        padding: '10px'
                                    }}>
                                        <div style={{ 
                                            fontWeight: 'bold',
                                            borderBottom: '1px solid #f0f0f0',
                                            marginBottom: '10px',
                                            paddingBottom: '5px'
                                        }}>
                                            Factored Loads
                                        </div>
                                        <div style={{ 
                                            display: 'flex',
                                            flexDirection: 'column',
                                            gap: '10px'
                                        }}>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Bending Moment (kNm)</div>
                                                <Input
                                                    style={{ width: '100%' }}
                                                    value={formData["Load.Moment"]}
                                                    onChange={(e) => handleInputChange("Load.Moment", e.target.value)}
                                                />
                                            </div>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Shear Force (kN)</div>
                                                <Input
                                                    style={{ width: '100%' }}
                                                    value={formData["Load.Shear"]}
                                                    onChange={(e) => handleInputChange("Load.Shear", e.target.value)}
                                                />
                                            </div>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Axial Force (kN)</div>
                                                <Input
                                                    style={{ width: '100%' }}
                                                    value={formData["Load.Axial"]}
                                                    onChange={(e) => handleInputChange("Load.Axial", e.target.value)}
                                                />
                                            </div>
                                        </div>
                                    </div>

                                    {/* Bolt Properties Section */}
                                    <div style={{ 
                                        marginBottom: '15px',
                                        border: '1px solid #f0f0f0',
                                        borderRadius: '4px',
                                        padding: '10px'
                                    }}>
                                        <div style={{ 
                                            fontWeight: 'bold',
                                            borderBottom: '1px solid #f0f0f0',
                                            marginBottom: '10px',
                                            paddingBottom: '5px'
                                        }}>
                                            Bolt
                                        </div>
                                        <div style={{ 
                                            display: 'flex',
                                            flexDirection: 'column',
                                            gap: '10px'
                                        }}>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Diameter (mm)</div>
                                                <Select
                                                    value={formData["Bolt.Diameter.Option"] || "All"}
                                                    style={{ width: '100%' }}
                                                    onChange={(value) => {
                                                        if (value === "All") {
                                                            handleInputChange("Bolt.Diameter", ["12", "16", "20", "24", "30", "36"]);
                                                        } else if (value === "Customized") {
                                                            setIsBoltSectionModalVisible(true);
                                                        }
                                                        handleInputChange("Bolt.Diameter.Option", value);
                                                    }}
                                                >
                                                    <Option value="All">All</Option>
                                                    <Option value="Customized">Customized</Option>
                                                </Select>
                                            </div>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Type</div>
                                                <Select
                                                    value={formData["Bolt.Type"]}
                                                    style={{ width: '100%' }}
                                                    onChange={(value) => handleInputChange("Bolt.Type", value)}
                                                    defaultValue="Bearing Bolt"
                                                >
                                                    <Option value="Bearing Bolt">Bearing Bolt</Option>
                                                    <Option value="Friction Grip Bolt">Friction Grip Bolt</Option>
                                                </Select>
                                            </div>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Property Class</div>
                                                <Select
                                                    value={formData["Bolt.Grade.Option"] || "All"}
                                                    style={{ width: '100%' }}
                                                    onChange={(value) => {
                                                        if (value === "All") {
                                                            handleInputChange("Bolt.Grade", ["4.6", "4.8", "5.6", "6.8", "8.8", "9.8", "10.9", "12.9"]);
                                                        } else if (value === "Customized") {
                                                            setIsBoltSectionModalVisible(true);
                                                        }
                                                        handleInputChange("Bolt.Grade.Option", value);
                                                    }}
                                                >
                                                    <Option value="All">All</Option>
                                                    <Option value="Customized">Customized</Option>
                                                </Select>
                                            </div>
                                        </div>
                                    </div>

                                    {/* Flange Splice Plate Section */}
                                    <div style={{ 
                                        marginBottom: '15px',
                                        border: '1px solid #f0f0f0',
                                        borderRadius: '4px',
                                        padding: '10px'
                                    }}>
                                        <div style={{ 
                                            fontWeight: 'bold',
                                            borderBottom: '1px solid #f0f0f0',
                                            marginBottom: '10px',
                                            paddingBottom: '5px'
                                        }}>
                                            Flange Splice Plate
                                        </div>
                                        <div style={{ 
                                            display: 'flex',
                                            flexDirection: 'column',
                                            gap: '10px'
                                        }}>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Preference</div>
                                                <Select
                                                    value={formData["Flange.Preference"] || "Outside"}
                                                    style={{ width: '100%' }}
                                                    onChange={(value) => handleInputChange("Flange.Preference", value)}
                                                    defaultValue="Outside"
                                                >
                                                    <Option value="Outside">Outside</Option>
                                                    <Option value="Outside+Inside">Outside+Inside</Option>
                                                </Select>
                                            </div>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Thickness (mm)</div>
                                                <Select
                                                    value={formData["Connector.Flange_Plate.Thickness.Option"] || "All"}
                                                    style={{ width: '100%' }}
                                                    onChange={(value) => {
                                                        if (value === "All") {
                                                            handleInputChange("Connector.Flange_Plate.Thickness_List", ["6", "8", "10", "12", "14", "16", "18", "20", "22", "25", "28", "32", "36", "40"]);
                                                        } else if (value === "Customized") {
                                                            setIsConnectorSectionModalVisible(true);
                                                        }
                                                        handleInputChange("Connector.Flange_Plate.Thickness.Option", value);
                                                    }}
                                                >
                                                    <Option value="All">All</Option>
                                                    <Option value="Customized">Customized</Option>
                                                </Select>
                                            </div>
                                        </div>
                                    </div>

                                    {/* Web Splice Plate Section */}
                                    <div style={{ 
                                        marginBottom: '15px',
                                        border: '1px solid #f0f0f0',
                                        borderRadius: '4px',
                                        padding: '10px'
                                    }}>
                                        <div style={{ 
                                            fontWeight: 'bold',
                                            borderBottom: '1px solid #f0f0f0',
                                            marginBottom: '10px',
                                            paddingBottom: '5px'
                                        }}>
                                            Web Splice Plate
                                        </div>
                                        <div style={{ 
                                            display: 'flex',
                                            flexDirection: 'column',
                                            gap: '10px'
                                        }}>
                                            <div style={{ marginBottom: '10px' }}>
                                                <div style={{ marginBottom: '5px' }}>Thickness (mm)</div>
                                                <Select
                                                    value={formData["Connector.Web_Plate.Thickness.Option"] || "All"}
                                                    style={{ width: '100%' }}
                                                    onChange={(value) => {
                                                        if (value === "All") {
                                                            handleInputChange("Connector.Web_Plate.Thickness_List", ["6", "8", "10", "12", "14", "16", "18", "20", "22", "25", "28", "32", "36", "40"]);
                                                        } else if (value === "Customized") {
                                                            setIsConnectorSectionModalVisible(true);
                                                        }
                                                        handleInputChange("Connector.Web_Plate.Thickness.Option", value);
                                                    }}
                                                >
                                                    <Option value="All">All</Option>
                                                    <Option value="Customized">Customized</Option>
                                                </Select>
                                            </div>
                                        </div>
                                    </div>

                                    {/* Action Buttons */}
                                    <div style={{ 
                                        display: 'flex',
                                        justifyContent: 'space-between',
                                        marginTop: '20px'
                                    }}>
                                        <Button 
                                            type="primary" 
                                            danger
                                            onClick={resetForm}
                                        >
                                            Reset
                                        </Button>
                                        <Button 
                                            type="primary"
                                            onClick={generateOutput}
                                            loading={loading}
                                        >
                                            Design
                                        </Button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </Col>
                    
                    {/* 3D View Column - exactly 1/3 width */}
                    <Col style={{ flex: '1 1 33.333%', height: '100%', padding: '0 1px' }}>
                        <div style={styles.contentSection}>
                            <div style={styles.sectionTitle}>3D View</div>
                            <div style={styles.sectionContent}>
                                <div style={styles.viewControls}>
                                    <div style={styles.viewButtons}>
                                        <Button style={{ marginRight: '5px' }}>Isometric</Button>
                                        <Button style={{ marginRight: '5px' }}>Front</Button>
                                        <Button>Side</Button>
                                    </div>
                                    <div style={styles.axisToggles}>
                                        <Checkbox defaultChecked style={{ marginRight: '10px' }}>Z</Checkbox>
                                        <Checkbox defaultChecked style={{ marginRight: '10px' }}>Y</Checkbox>
                                        <Checkbox defaultChecked style={{ marginRight: '10px' }}>Lx</Checkbox>
                                        <Checkbox defaultChecked>Ly</Checkbox>
                                    </div>
                                    <div style={styles.modelToggles}>
                                        <Checkbox defaultChecked style={{ marginRight: '10px' }}>Model</Checkbox>
                                        <Checkbox defaultChecked style={{ marginRight: '10px' }}>Column</Checkbox>
                                        <Checkbox defaultChecked>Cover Plate</Checkbox>
                                    </div>
                                </div>
                                <div style={styles.viewerContainer}>
                                    <ErrorBoundary 
                                        fallbackMessage="There was an error rendering the 3D model"
                                        showResetButton={true}
                                        onReset={() => setResetFlag(!resetFlag)}
                                        showDetails={true}
                                    >
                                        <ThreeRender resetFlag={resetFlag} hasOutput={modelGenerated} />
                                    </ErrorBoundary>
                                </div>
                                <div style={styles.logConsole}>
                                    {logs && logs.length > 0 && (
                                        <div>
                                            {logs.slice(0, 5).map((log, index) => (
                                                <div key={index} style={{
                                                    color: log.type === 'ERROR' ? 'red' : 
                                                           log.type === 'WARNING' ? '#faad14' : 'inherit',
                                                    marginBottom: '2px'
                                                }}>
                                                    {log.msg}
                                                </div>
                                            ))}
                                        </div>
                                    )}
                                </div>
                            </div>
                        </div>
                    </Col>
                    
                    {/* Output Column - exactly 1/3 width */}
                    <Col style={{ flex: '1 1 33.333%', height: '100%', padding: '0 1px' }}>
                        <div style={styles.contentSection}>
                            <div style={styles.sectionTitle}>Output Dock</div>
                            <div style={styles.sectionContent}>
                                <div style={styles.outputContainer}>
                                    <div style={styles.outputSection}>
                                        <div style={styles.outputSectionHeader}>Member Capacity</div>
                                        <Button size="small" style={{ marginBottom: '10px', width: '100%' }}>Member Capacity</Button>
                                        
                                        <div style={styles.outputSectionHeader}>Bolt</div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Diameter (mm):</span>
                                            <Input 
                                                size="small"
                                                value={output && output["Bolt.Diameter"] ? output["Bolt.Diameter"].value : ""}
                                                readOnly
                                                style={{ width: '58%' }}
                                            />
                                        </div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Property Class:</span>
                                            <Select
                                                size="small"
                                                value={output && output["Bolt.Grade"] ? output["Bolt.Grade"].value : ""}
                                                disabled
                                                style={{ width: '58%' }}
                                            >
                                                <Option value={output && output["Bolt.Grade"] ? output["Bolt.Grade"].value : ""}>
                                                    {output && output["Bolt.Grade"] ? output["Bolt.Grade"].value : ""}
                                                </Option>
                                            </Select>
                                        </div>
                                        <div style={{ display: 'flex', flexDirection: 'column', gap: '5px', marginTop: '5px', marginBottom: '10px' }}>
                                            <Button size="small" style={{ width: '100%' }}>Flange Bolt Capacity</Button>
                                            <Button size="small" style={{ width: '100%' }}>Web Bolt Capacity</Button>
                                        </div>
                                        
                                        <div style={styles.outputSectionHeader}>Web Splice Plate</div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Height (mm):</span>
                                            <Input 
                                                size="small"
                                                value={output && output["WebPlate.Height"] ? output["WebPlate.Height"].value : ""}
                                                readOnly
                                                style={{ width: '58%' }}
                                            />
                                        </div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Width (mm):</span>
                                            <Input 
                                                size="small"
                                                value={output && output["WebPlate.Width"] ? output["WebPlate.Width"].value : ""}
                                                readOnly
                                                style={{ width: '58%' }}
                                            />
                                        </div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Thickness (mm):</span>
                                            <Input 
                                                size="small"
                                                value={output && output["WebPlate.Thickness"] ? output["WebPlate.Thickness"].value : ""}
                                                readOnly
                                                style={{ width: '58%' }}
                                            />
                                        </div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Spacing (mm):</span>
                                            <Input 
                                                size="small"
                                                value={output && output["WebPlate.Spacing"] ? output["WebPlate.Spacing"].value : ""}
                                                readOnly
                                                style={{ width: '58%' }}
                                            />
                                        </div>
                                        <div style={{ display: 'flex', flexDirection: 'column', gap: '5px', marginTop: '5px', marginBottom: '10px' }}>
                                            <Button size="small" style={{ width: '100%' }}>Web Spacing Details</Button>
                                            <Button size="small" style={{ width: '100%' }}>Web Capacity</Button>
                                        </div>
                                        
                                        <div style={styles.outputSectionHeader}>Flange Splice Plate Outer Plate</div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Width (mm):</span>
                                            <Input 
                                                size="small"
                                                value={output && output["FlangePlate.Width"] ? output["FlangePlate.Width"].value : ""}
                                                readOnly
                                                style={{ width: '58%' }}
                                            />
                                        </div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Length (mm):</span>
                                            <Input 
                                                size="small"
                                                value={output && output["FlangePlate.Length"] ? output["FlangePlate.Length"].value : ""}
                                                readOnly
                                                style={{ width: '58%' }}
                                            />
                                        </div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Thickness (mm):</span>
                                            <Input 
                                                size="small"
                                                value={output && output["FlangePlate.Thickness"] ? output["FlangePlate.Thickness"].value : ""}
                                                readOnly
                                                style={{ width: '58%' }}
                                            />
                                        </div>
                                        <div style={styles.outputField}>
                                            <span style={styles.outputLabel}>Spacing (mm):</span>
                                            <Input 
                                                size="small"
                                                value={output && output["FlangePlate.Spacing"] ? output["FlangePlate.Spacing"].value : ""}
                                                readOnly
                                                style={{ width: '58%' }}
                                            />
                                        </div>
                                        <div style={{ display: 'flex', flexDirection: 'column', gap: '5px', marginTop: '5px', marginBottom: '10px' }}>
                                            <Button size="small" style={{ width: '100%' }}>Flange Spacing Details</Button>
                                            <Button size="small" style={{ width: '100%' }}>Flange Capacity</Button>
                                        </div>
                                    </div>
                                    <div style={{ 
                                        marginTop: '10px', 
                                        display: 'flex', 
                                        justifyContent: 'space-between',
                                        gap: '5px'
                                    }}>
                                        <Button 
                                            size="small"
                                            icon={<FileTextOutlined />} 
                                            onClick={generateReport}
                                            style={{ flex: 1 }}
                                            disabled={!output}
                                        >
                                            Create Design Report
                                        </Button>
                                        <Button 
                                            size="small"
                                            icon={<SaveOutlined />} 
                                            onClick={saveInputFile}
                                            style={{ flex: 1 }}
                                            disabled={!output}
                                        >
                                            Save Output
                                        </Button>
                                    </div>
                                </div>

                                {logs && logs.length > 0 && (
                                    <div style={{ marginTop: '10px' }}>
                                        <h4 style={{ margin: '5px 0' }}>Logs</h4>
                                        <div style={{ 
                                            maxHeight: '150px', 
                                            overflow: 'auto', 
                                            border: '1px solid #ddd', 
                                            padding: '3px',
                                            fontSize: '12px'
                                        }}>
                                            {logs.map((log, index) => (
                                                <div key={index} style={{
                                                    color: log.type === 'ERROR' ? 'red' : 
                                                           log.type === 'WARNING' ? '#faad14' : 'inherit',
                                                    marginBottom: '2px'
                                                }}>
                                                    {log.msg}
                                                </div>
                                            ))}
                                        </div>
                                    </div>
                                )}
                            </div>
                        </div>
                    </Col>
                </Row>
            </Content>

            {/* Modals */}
            <ColumnSectionModal
                visible={isColumnSectionModalVisible}
                onCancel={() => setIsColumnSectionModalVisible(false)}
                onOk={(selectedValue) => {
                    handleInputChange("Member.Supporting_Section.Designation", selectedValue);
                    handleInputChange("Member.Supported_Section.Designation", selectedValue);
                    setIsColumnSectionModalVisible(false);
                }}
                resetFlag={resetFlag}
            />

            <BoltSectionModal
                visible={isBoltSectionModalVisible}
                onCancel={() => setIsBoltSectionModalVisible(false)}
                onOk={(values) => {
                    for (const [key, value] of Object.entries(values)) {
                        handleInputChange(key, value);
                    }
                    setIsBoltSectionModalVisible(false);
                }}
                initialValues={{
                    "Bolt.Diameter": formData["Bolt.Diameter"],
                    "Bolt.Type": formData["Bolt.Type"],
                    "Bolt.Grade": formData["Bolt.Grade"],
                    "Bolt.Bolt_Hole_Type": formData["Bolt.Bolt_Hole_Type"],
                    "Bolt.Slip_Factor": formData["Bolt.Slip_Factor"],
                    "Bolt.TensionType": formData["Bolt.TensionType"],
                }}
                resetFlag={resetFlag}
            />

            <WeldSectionModal
                visible={isWeldSectionModalVisible}
                onCancel={() => setIsWeldSectionModalVisible(false)}
                onOk={(values) => {
                    for (const [key, value] of Object.entries(values)) {
                        handleInputChange(key, value);
                    }
                    setIsWeldSectionModalVisible(false);
                }}
                initialValues={{
                    "Weld.Fab": formData["Weld.Fab"],
                    "Weld.Material_Grade_OverWrite": formData["Weld.Material_Grade_OverWrite"],
                }}
                resetFlag={resetFlag}
            />

            <DetailingSectionModal
                visible={isDetailingSectionModalVisible}
                onCancel={() => setIsDetailingSectionModalVisible(false)}
                onOk={(values) => {
                    for (const [key, value] of Object.entries(values)) {
                        handleInputChange(key, value);
                    }
                    setIsDetailingSectionModalVisible(false);
                }}
                initialValues={{
                    "Detailing.Corrosive_Influences": formData["Detailing.Corrosive_Influences"],
                    "Detailing.Edge_type": formData["Detailing.Edge_type"],
                    "Detailing.Gap": formData["Detailing.Gap"],
                }}
                resetFlag={resetFlag}
            />

            <DesignSectionModal
                visible={isDesignSectionModalVisible}
                onCancel={() => setIsDesignSectionModalVisible(false)}
                onOk={(values) => {
                    for (const [key, value] of Object.entries(values)) {
                        handleInputChange(key, value);
                    }
                    setIsDesignSectionModalVisible(false);
                }}
                initialValues={{
                    "Design.Design_Method": formData["Design.Design_Method"],
                }}
                resetFlag={resetFlag}
            />

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

            <CustomSectionModal
                visible={isCustomSectionModalVisible}
                onCancel={() => setIsCustomSectionModalVisible(false)}
                onOk={(values) => {
                    for (const [key, value] of Object.entries(values)) {
                        handleInputChange(key, value);
                    }
                    setIsCustomSectionModalVisible(false);
                }}
                resetFlag={resetFlag}
            />
        </Layout>
    );
};

export default ColumnCoverPlateBolted; 