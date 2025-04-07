import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import Cookies from 'js-cookie';
import Variable from '../Variable';
import { Table, Modal, Button, Layout, Menu, Select, Radio, Input, Space, Divider, Dropdown, notification, Checkbox, Row, Col, ConfigProvider, theme } from 'antd';
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
import { FileTextOutlined, SaveOutlined, FileOutlined, EditOutlined, DatabaseOutlined, QuestionOutlined, SettingOutlined, DownOutlined, FolderOutlined, DownloadOutlined } from '@ant-design/icons';
import ErrorBoundary from './ErrorBoundary';
import DesignPreferences from './DesignPreferences';

const { Content, Header } = Layout;
const { Option } = Select;

// Style definitions
const styles = {
    layout: { 
        height: '100vh', 
        display: 'flex', 
        flexDirection: 'column',
        overflow: 'hidden',
        width: '100%',
        backgroundColor: '#141414',
        position: 'fixed',
        top: 0,
        left: 0,
        right: 0,
        bottom: 0
    },
    header: { 
        height: '40px', 
        lineHeight: '40px', 
        padding: '0 20px', 
        background: '#1f1f1f',
        width: '100%',
        color: '#fff',
        flexShrink: 0
    },
    title: { 
        textAlign: 'center', 
        padding: '5px 0', 
        fontSize: '18px', 
        fontWeight: 'bold',
        borderBottom: '1px solid #303030',
        width: '100%',
        color: '#fff',
        flexShrink: 0,
        height: '35px'
    },
    mainContent: { 
        flex: 1, 
        padding: '5px', 
        overflow: 'hidden',
        display: 'flex',
        width: '100%',
        backgroundColor: '#141414',
        minHeight: 0,
        height: 'calc(100vh - 80px)'  // Subtract header and title height
    },
    column: {
        height: '100%',
        flex: 1,
        padding: '0 2px'
    },
    contentSection: {
        height: '100%', 
        border: '1px solid #303030',
        borderRadius: '4px', 
        display: 'flex',
        flexDirection: 'column',
        backgroundColor: '#1f1f1f',
        overflow: 'hidden',
        flex: 1
    },
    sectionTitle: {
        padding: '8px', 
        borderBottom: '1px solid #303030',
        background: '#141414',
        fontWeight: 'bold',
        fontSize: '14px',
        color: '#fff',
        flexShrink: 0
    },
    sectionContent: {
        flex: 1,
        overflow: 'auto',
        backgroundColor: '#1f1f1f',
        minHeight: 0,
        display: 'flex',
        flexDirection: 'column',
        height: '100%'
    },
    viewerContainer: {
        flex: 1,
        minHeight: '280px',
        position: 'relative',
        backgroundColor: '#141414'  // Dark background for viewer
    },
    logConsole: {
        marginTop: '5px', 
        maxHeight: '80px', 
        overflow: 'auto', 
        border: '1px solid #303030',  // Darker border
        padding: '3px',
        backgroundColor: '#1f1f1f',  // Darker console background
        color: '#fff'  // White text
    },
    actionButtons: {
        padding: '15px',
        display: 'flex',
        flexDirection: 'column',
        gap: '8px',
        backgroundColor: '#1f1f1f',
        borderTop: '1px solid #303030'
    },
    inputSection: {
        marginBottom: '15px',
        border: '1px solid #303030',  // Darker border
        borderRadius: '4px',
        padding: '10px',
        backgroundColor: '#1f1f1f'  // Darker section background
    },
    sectionHeader: {
        fontWeight: 'bold',
        borderBottom: '1px solid #303030',  // Darker border
        marginBottom: '10px',
        paddingBottom: '5px',
        color: '#fff'  // White text
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
        flex: 1,
        display: 'flex',
        flexDirection: 'column',
        backgroundColor: '#1f1f1f',
        minHeight: 0,
        overflow: 'hidden'
    },
    outputSection: {
        flex: 1,
        overflowY: 'auto',
        padding: '15px',
        minHeight: 0,
        backgroundColor: '#1f1f1f'
    },
    outputSectionHeader: {
        color: '#fff',
        fontSize: '14px',
        fontWeight: 'normal',
        marginBottom: '8px'
    },
    outputField: {
        marginBottom: '10px'
    },
    outputLabel: {
        color: '#fff',
        fontSize: '14px',
        marginBottom: '5px'
    },
    outputValue: {
        width: '100%',
        backgroundColor: '#141414',
        border: '1px solid #1f1f1f',
        borderRadius: '2px',
        color: '#fff'
    },
    outputButton: {
        width: '100%',
        backgroundColor: 'rgba(255, 255, 255, 0.1)',
        border: 'none',
        color: '#fff',
        marginBottom: '8px',
        height: '32px',
        textAlign: 'center'
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
        flexDirection: 'row',
        gap: '10px',
        padding: '10px',
        backgroundColor: '#1f1f1f',
        borderBottom: '1px solid #303030',
        alignItems: 'center',
        justifyContent: 'space-between'
    },
    orientationButtons: {
        display: 'flex',
        gap: '10px',
        marginRight: '20px'
    },
    orientationButton: {
        width: '40px',
        height: '40px',
        padding: '4px',
        backgroundColor: '#141414',
        border: '1px solid #303030',
        cursor: 'pointer',
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'space-between'
    },
    buttonBars: {
        display: 'flex',
        height: '8px',
        gap: '2px'
    },
    blueBar: {
        backgroundColor: '#1890ff',
        flex: 1
    },
    whiteBar: {
        backgroundColor: '#fff',
        flex: 1
    },
    viewButtons: {
        display: 'flex',
        gap: '5px'
    },
    axisToggles: {
        display: 'flex',
        gap: '10px',
        alignItems: 'center'
    },
    modelToggles: {
        display: 'flex',
        gap: '10px',
        alignItems: 'center'
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

    // Add state for download modal
    const [downloadModalVisible, setDownloadModalVisible] = useState(false);
    const [downloadType, setDownloadType] = useState('');
    const [downloadFileName, setDownloadFileName] = useState('');
    const [downloadTags, setDownloadTags] = useState('');
    const [downloadLocation, setDownloadLocation] = useState('');
    const [exceptionModalVisible, setExceptionModalVisible] = useState(false);
    const [tutorialsModalVisible, setTutorialsModalVisible] = useState(false);
    const [askQuestionModalVisible, setAskQuestionModalVisible] = useState(false);
    const [resetModalVisible, setResetModalVisible] = useState(false);
    const [aboutModalVisible, setAboutModalVisible] = useState(false);

    // Add state for design preferences modal
    const [isDesignPreferencesVisible, setIsDesignPreferencesVisible] = useState(false);

    // Add state for view expansion
    const [expandLeft, setExpandLeft] = useState(false);
    const [expandRight, setExpandRight] = useState(false);

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

    // Handle saving design preferences
    const handleSaveDesignPreferences = (values) => {
        console.log('Design preferences saved:', values);
        // Here you would update your formData with the new preferences
        notification.success({
            message: 'Success',
            description: 'Design preferences saved successfully'
        });
        setIsDesignPreferencesVisible(false);
    };

    // Add handlers for other menu items
    const handleEditMenuClick = ({ key }) => {
        switch(key) {
            case 'design-preferences':
                setIsDesignPreferencesVisible(true);
                break;
            case 'section-modeler':
                setExceptionModalVisible(true);
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

    // Update the database menu click handler with better debugging
    const handleDatabaseMenuClick = ({ key }) => {
        if (key === 'reset') {
            setResetModalVisible(true);
        }
        console.log("Database menu item clicked:", key);
        
        switch(key) {
            case 'download-column':
                console.log("Showing column download dialog");
                setDownloadType('Column');
                setDownloadFileName('Column_Details');
                setDownloadLocation(process.env.HOME || process.env.USERPROFILE || 'Downloads');
                setDownloadModalVisible(true);
                break;
            case 'download-beam':
                console.log("Showing beam download dialog");
                setDownloadType('Beam');
                setDownloadFileName('Beam_Details');
                setDownloadLocation(process.env.HOME || process.env.USERPROFILE || 'Downloads');
                setDownloadModalVisible(true);
                break;
            case 'download-angle':
                console.log("Showing angle download dialog");
                setDownloadType('Angle');
                setDownloadFileName('Angle_Details');
                setDownloadLocation(process.env.HOME || process.env.USERPROFILE || 'Downloads');
                setDownloadModalVisible(true);
                break;
            case 'download-channel':
                console.log("Showing channel download dialog");
                setDownloadType('Channel');
                setDownloadFileName('Channel_Details');
                setDownloadLocation(process.env.HOME || process.env.USERPROFILE || 'Downloads');
                setDownloadModalVisible(true);
                break;
            default:
                console.log("Unknown database menu item:", key);
                break;
        }
    };

    // Update the handleHelpMenuClick function
    const handleHelpMenuClick = ({ key }) => {
        switch(key) {
            case 'tutorials':
                setTutorialsModalVisible(true);
                break;
            case 'examples':
                setExceptionModalVisible(true);
                break;
            case 'question':
                setAskQuestionModalVisible(true);
                break;
            case 'about':
                setAboutModalVisible(true);
                break;
            case 'update':
                notification.info({
                    message: 'Check For Update',
                    description: 'Checking for updates...'
                });
                break;
            default:
                break;
        }
    };

    // Add a direct test function to open the download modal
    const testOpenDownloadModal = (type) => {
        console.log(`Opening download modal for ${type}`);
        setDownloadType(type);
        setDownloadFileName(`${type}_Details`);
        setDownloadLocation('Downloads');
        setDownloadModalVisible(true);
    };

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
    const databaseMenu = (
        <Menu onClick={handleDatabaseMenuClick}>
            <Menu.SubMenu key="download" title="Download">
                <Menu.Item key="download-column">Column</Menu.Item>
                <Menu.Item key="download-beam">Beam</Menu.Item>
                <Menu.Item key="download-angle">Angle</Menu.Item>
                <Menu.Item key="download-channel">Channel</Menu.Item>
            </Menu.SubMenu>
            <Menu.Item key="reset">Reset</Menu.Item>
        </Menu>
    );

    // Add the missing handleDownload function
    const handleDownload = () => {
        if (!downloadFileName) {
            notification.error({
                message: 'Error',
                description: 'Please enter a filename'
            });
            return;
        }

        // Simulate download process
        notification.success({
            message: 'Success',
            description: `${downloadType} data will be downloaded as ${downloadFileName} to ${downloadLocation || 'Downloads'}`
        });
        
        setDownloadModalVisible(false);
    };

    // Handle view expansion
    const handleLeftExpand = () => {
        setExpandLeft(!expandLeft);
        setExpandRight(false);
    };

    const handleRightExpand = () => {
        setExpandRight(!expandRight);
        setExpandLeft(false);
    };

    return (
        <ConfigProvider
            theme={{
                algorithm: theme.darkAlgorithm,
                token: {
                    colorPrimary: '#1890ff',
                    colorBgContainer: '#141414',
                    colorBgElevated: '#1f1f1f',
                    colorText: '#fff',
                    colorBorder: '#303030',
                    borderRadius: 4,
                }
            }}
        >
            <Layout style={styles.layout}>
                {/* Top Navigation Bar */}
                <Header style={styles.header}>
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
                <div style={styles.title}>
                    Column Cover Plate Bolted Connection
                </div>

                {/* Main Content */}
                <Content style={styles.mainContent}>
                    <Row style={{ 
                        width: '100%', 
                        height: '100%', 
                        margin: 0, 
                        padding: 0,
                        display: 'flex',
                        flexDirection: 'row',
                        minHeight: 0,
                        backgroundColor: '#141414',
                        flex: 1
                    }}>
                        {/* Input Column */}
                        <Col span={expandLeft ? 0 : 8} style={{ height: '100%', padding: '0 1px', transition: 'all 0.3s ease', overflow: 'hidden' }}>
                            <div style={styles.contentSection}>
                                <div style={styles.sectionTitle}>Input</div>
                                <div style={styles.sectionContent}>
                                    <div style={{ width: '100%' }}>
                                        {/* Connecting Members Section */}
                                        <div style={{ 
                                            marginBottom: '15px',
                                            border: '1px solid #303030',  // Darker border
                                            borderRadius: '4px',
                                            padding: '10px',
                                            backgroundColor: '#1f1f1f'  // Darker section background
                                        }}>
                                            <div style={{ 
                                                fontWeight: 'bold',
                                                borderBottom: '1px solid #303030',  // Darker border
                                                marginBottom: '10px',
                                                paddingBottom: '5px',
                                                color: '#fff'  // White text
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
                                            border: '1px solid #303030',  // Darker border
                                            borderRadius: '4px',
                                            padding: '10px',
                                            backgroundColor: '#1f1f1f'  // Darker section background
                                        }}>
                                            <div style={{ 
                                                fontWeight: 'bold',
                                                borderBottom: '1px solid #303030',  // Darker border
                                                marginBottom: '10px',
                                                paddingBottom: '5px',
                                                color: '#fff'  // White text
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
                                            border: '1px solid #303030',  // Darker border
                                            borderRadius: '4px',
                                            padding: '10px',
                                            backgroundColor: '#1f1f1f'  // Darker section background
                                        }}>
                                            <div style={{ 
                                                fontWeight: 'bold',
                                                borderBottom: '1px solid #303030',  // Darker border
                                                marginBottom: '10px',
                                                paddingBottom: '5px',
                                                color: '#fff'  // White text
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
                                            border: '1px solid #303030',  // Darker border
                                            borderRadius: '4px',
                                            padding: '10px',
                                            backgroundColor: '#1f1f1f'  // Darker section background
                                        }}>
                                            <div style={{ 
                                                fontWeight: 'bold',
                                                borderBottom: '1px solid #303030',  // Darker border
                                                marginBottom: '10px',
                                                paddingBottom: '5px',
                                                color: '#fff'  // White text
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
                                            border: '1px solid #303030',  // Darker border
                                            borderRadius: '4px',
                                            padding: '10px',
                                            backgroundColor: '#1f1f1f'  // Darker section background
                                        }}>
                                            <div style={{ 
                                                fontWeight: 'bold',
                                                borderBottom: '1px solid #303030',  // Darker border
                                                marginBottom: '10px',
                                                paddingBottom: '5px',
                                                color: '#fff'  // White text
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
                        
                        {/* 3D View Column */}
                        <Col span={expandLeft ? 16 : expandRight ? 16 : 8} style={{ height: '100%', padding: '0 1px', transition: 'all 0.3s ease' }}>
                            <div style={styles.contentSection}>
                                <div style={styles.sectionTitle}>3D View</div>
                                <div style={styles.sectionContent}>
                                    <div style={styles.viewControls}>
                                        <div style={styles.orientationButtons}>
                                            {/* Left expand button */}
                                            <div 
                                                style={styles.orientationButton} 
                                                onClick={handleLeftExpand}
                                                title="Expand view to left"
                                            >
                                                <div style={styles.buttonBars}>
                                                    <div style={styles.blueBar} />
                                                    <div style={styles.whiteBar} />
                                                    <div style={styles.whiteBar} />
                                                </div>
                                                <div style={styles.buttonBars}>
                                                    <div style={styles.blueBar} />
                                                    <div style={styles.whiteBar} />
                                                    <div style={styles.whiteBar} />
                                                </div>
                                                <div style={styles.buttonBars}>
                                                    <div style={styles.blueBar} />
                                                    <div style={styles.whiteBar} />
                                                    <div style={styles.whiteBar} />
                                                </div>
                                            </div>
                                            {/* Right expand button */}
                                            <div 
                                                style={styles.orientationButton}
                                                onClick={handleRightExpand}
                                                title="Expand view to right"
                                            >
                                                <div style={styles.buttonBars}>
                                                    <div style={styles.whiteBar} />
                                                    <div style={styles.whiteBar} />
                                                    <div style={styles.blueBar} />
                                                </div>
                                                <div style={styles.buttonBars}>
                                                    <div style={styles.whiteBar} />
                                                    <div style={styles.whiteBar} />
                                                    <div style={styles.blueBar} />
                                                </div>
                                                <div style={styles.buttonBars}>
                                                    <div style={styles.whiteBar} />
                                                    <div style={styles.whiteBar} />
                                                    <div style={styles.blueBar} />
                                                </div>
                                            </div>
                                        </div>
                                        <div style={styles.viewButtons}>
                                    <Button
                                                style={{ 
                                                    backgroundColor: '#141414',
                                                    color: '#fff',
                                                    border: '1px solid #303030'
                                                }}
                                            >
                                                Isometric
                                            </Button>
                                            <Button 
                                                style={{ 
                                                    backgroundColor: '#141414',
                                                    color: '#fff',
                                                    border: '1px solid #303030'
                                                }}
                                            >
                                                Front
                                            </Button>
                                            <Button 
                                                style={{ 
                                                    backgroundColor: '#141414',
                                                    color: '#fff',
                                                    border: '1px solid #303030'
                                                }}
                                            >
                                                Side
                                    </Button>
                                </div>
                                        <div style={styles.axisToggles}>
                                            <Checkbox 
                                                defaultChecked 
                                                style={{ color: '#fff' }}
                                            >
                                                Z
                                            </Checkbox>
                                            <Checkbox 
                                                defaultChecked 
                                                style={{ color: '#fff' }}
                                            >
                                                Y
                                            </Checkbox>
                                            <Checkbox 
                                                defaultChecked 
                                                style={{ color: '#fff' }}
                                            >
                                                Lx
                                            </Checkbox>
                                            <Checkbox 
                                                defaultChecked 
                                                style={{ color: '#fff' }}
                                            >
                                                Ly
                                            </Checkbox>
                                </div>
                                        <div style={styles.modelToggles}>
                                            <Checkbox 
                                                defaultChecked 
                                                style={{ color: '#fff' }}
                                            >
                                                Model
                                            </Checkbox>
                                            <Checkbox 
                                                defaultChecked 
                                                style={{ color: '#fff' }}
                                            >
                                                Column
                                            </Checkbox>
                                            <Checkbox 
                                                defaultChecked 
                                                style={{ color: '#fff' }}
                                            >
                                                Cover Plate
                                            </Checkbox>
                                        </div>
                                    </div>
                                    <div style={styles.viewerContainer}>
                                        <ErrorBoundary>
                                            <ThreeRender 
                                                resetFlag={resetFlag}
                                                hasOutput={modelGenerated}
                                                showMessage={true}
                                            />
                                        </ErrorBoundary>
                                    </div>
                                    <div style={styles.logConsole}>
                                {logs && logs.length > 0 && (
                                            <div>
                                                {logs.slice(0, 5).map((log, index) => (
                                                    <div key={index} style={{
                                                        color: log.type === 'ERROR' ? 'red' : 
                                                               log.type === 'WARNING' ? '#faad14' : '#fff',
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
                        
                        {/* Output Column */}
                        <Col span={expandRight ? 0 : 8} style={{ height: '100%', padding: '0 1px', transition: 'all 0.3s ease', overflow: 'hidden' }}>
                            <div style={styles.contentSection}>
                                <div style={styles.sectionTitle}>Output</div>
                                <div style={styles.sectionContent}>
                                    <div style={styles.outputContainer}>
                                        <div style={styles.outputSection}>
                                            {/* Member Capacity Section */}
                                            <div style={{ marginBottom: '20px' }}>
                                                <div style={styles.outputSectionHeader}>Member Capacity</div>
                                                <Button style={styles.outputButton}>
                                                    Member Capacity
                </Button>
                                            </div>

                                            {/* Bolt Section */}
                                            <div style={{ marginBottom: '20px' }}>
                                                <div style={styles.outputSectionHeader}>Bolt</div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Diameter (mm)</div>
                                                    <Input
                                                        value={output?.["Bolt.Diameter"]?.value || ""}
                                                        readOnly
                                                        style={styles.outputValue}
                                                    />
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Property Class *</div>
                                                    <Input
                                                        value={output?.["Bolt.Grade"]?.value || ""}
                                                        readOnly
                                                        style={styles.outputValue}
                                                    />
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Bolt Capacities</div>
                                                    <Button style={styles.outputButton}>
                                                        Flange Bolt Capacity
                </Button>
                                                    <Button style={styles.outputButton}>
                                                        Web Bolt Capacity
                </Button>
                                                </div>
            </div>

                                            {/* Web Splice Plate Section */}
                                            <div style={{ marginBottom: '20px' }}>
                                                <div style={styles.outputSectionHeader}>Web Splice Plate</div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Height (mm)</div>
                                                    <Input
                                                        value={output?.["WebPlate.Height"]?.value || ""}
                                                        readOnly
                                                        style={styles.outputValue}
                                                    />
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Width (mm)</div>
                                                    <Input
                                                        value={output?.["WebPlate.Width"]?.value || ""}
                                                        readOnly
                                                        style={styles.outputValue}
                                                    />
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Thickness (mm) *</div>
                                                    <Input
                                                        value={output?.["WebPlate.Thickness"]?.value || ""}
                                                        readOnly
                                                        style={styles.outputValue}
                                                    />
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Spacing (mm)</div>
                                                    <Button style={styles.outputButton}>
                                                        Web Spacing Details
                                                    </Button>
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Capacity</div>
                                                    <Button style={styles.outputButton}>
                                                        Web Capacity
                                                    </Button>
                                                </div>
                                            </div>

                                            {/* Flange Splice Plate Section */}
                                            <div style={{ marginBottom: '20px' }}>
                                                <div style={styles.outputSectionHeader}>Flange Splice Plate Outer Plate</div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Width (mm)</div>
                                                    <Input
                                                        value={output?.["FlangePlate.Width"]?.value || ""}
                                                        readOnly
                                                        style={styles.outputValue}
                                                    />
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Length (mm)</div>
                                                    <Input
                                                        value={output?.["FlangePlate.Length"]?.value || ""}
                                                        readOnly
                                                        style={styles.outputValue}
                                                    />
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Thickness (mm) *</div>
                                                    <Input
                                                        value={output?.["FlangePlate.Thickness"]?.value || ""}
                                                        readOnly
                                                        style={styles.outputValue}
                                                    />
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Spacing (mm)</div>
                                                    <Button style={styles.outputButton}>
                                                        Flange Spacing Details
                                                    </Button>
                                                </div>
                                                <div style={styles.outputField}>
                                                    <div style={styles.outputLabel}>Capacity</div>
                                                    <Button style={styles.outputButton}>
                                                        Flange Capacity
                                                    </Button>
                                                </div>
                                            </div>
                                        </div>

                                        <div style={styles.actionButtons}>
                                            <Button 
                                                onClick={generateReport}
                                                style={{
                                                    backgroundColor: '#8B0000',
                                                    color: '#fff',
                                                    border: 'none',
                                                    height: '40px'
                                                }}
                                            >
                                                Create design report
                                            </Button>
                                            <Button 
                                                onClick={saveInputFile}
                                                style={{
                                                    backgroundColor: '#8B0000',
                                                    color: '#fff',
                                                    border: 'none',
                                                    height: '40px'
                                                }}
                                            >
                                                Save Output
                                            </Button>
                                        </div>
                                    </div>
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

                {/* Design Preferences Modal */}
                <Modal
                    title={null}
                    open={isDesignPreferencesVisible}
                    onCancel={() => setIsDesignPreferencesVisible(false)}
                    footer={null}
                    width={1000}
                    bodyStyle={{ padding: 0 }}
                    destroyOnClose
                    maskClosable={false}
                    centered
                >
                    <DesignPreferences
                        onCancel={() => setIsDesignPreferencesVisible(false)}
                        onSave={handleSaveDesignPreferences}
                        initialValues={{
                            bolt: {
                                boltType: formData["Bolt.TensionType"] || "Pre-tensioned",
                                holeType: formData["Bolt.Bolt_Hole_Type"] || "Standard",
                                slipFactor: formData["Bolt.Slip_Factor"] || "0.3"
                            }
                        }}
                        showMessage={false}
                    />
                </Modal>

                {/* Add the download modal component to the layout */}
                <Modal
                    title="Download File"
                    open={downloadModalVisible}
                    onCancel={() => setDownloadModalVisible(false)}
                    centered
                    destroyOnClose
                    maskClosable={false}
                    width={550}
                    footer={[
                        <Button 
                            key="cancel" 
                            onClick={() => setDownloadModalVisible(false)}
                            style={{
                                background: "#555",
                                color: "white",
                                border: "none",
                                borderRadius: "4px"
                            }}
                        >
                            Cancel
                        </Button>,
                        <Button 
                            key="save" 
                            type="primary" 
                            onClick={handleDownload}
                            style={{
                                background: "#1890ff", 
                                borderColor: "#1890ff"
                            }}
                        >
                            Save
                        </Button>
                    ]}
                    bodyStyle={{ 
                        background: '#2d2d2d', 
                        padding: '25px', 
                        color: 'white',
                        borderRadius: '5px'
                    }}
                    style={{ 
                        top: '30%',
                    }}
                >
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                        <div style={{ display: 'flex', alignItems: 'center' }}>
                            <div style={{ width: '120px', textAlign: 'right', paddingRight: '20px', color: '#ccc' }}>
                                Save As:
                            </div>
                            <div style={{ flex: 1 }}>
                                <Input 
                                    value={downloadFileName}
                                    onChange={(e) => setDownloadFileName(e.target.value)}
                                    style={{ 
                                        background: '#444', 
                                        border: '1px solid #666',
                                        borderRadius: '5px',
                                        color: 'white',
                                        height: '32px'
                                    }}
                                />
                            </div>
                        </div>
                        
                        <div style={{ display: 'flex', alignItems: 'center' }}>
                            <div style={{ width: '120px', textAlign: 'right', paddingRight: '20px', color: '#ccc' }}>
                                Tags:
                            </div>
                            <div style={{ flex: 1 }}>
                                <Input 
                                    value={downloadTags}
                                    onChange={(e) => setDownloadTags(e.target.value)}
                                    style={{ 
                                        background: '#444', 
                                        border: '1px solid #666',
                                        borderRadius: '5px',
                                        color: 'white',
                                        height: '32px'
                                    }}
                                    placeholder="Optional tags"
                                />
                            </div>
                        </div>
                        
                        <div style={{ display: 'flex', alignItems: 'center' }}>
                            <div style={{ width: '120px', textAlign: 'right', paddingRight: '20px', color: '#ccc' }}>
                                Where:
                            </div>
                            <div style={{ flex: 1, display: 'flex', gap: '10px' }}>
                                <Button 
                                    icon={<FolderOutlined />} 
                                    style={{ 
                                        background: '#444', 
                                        border: '1px solid #666',
                                        borderRadius: '5px',
                                        color: 'white',
                                        width: '85%',
                                        textAlign: 'left',
                                        overflow: 'hidden',
                                        textOverflow: 'ellipsis',
                                        whiteSpace: 'nowrap'
                                    }}
                                >
                                    {downloadLocation || 'Downloads'}
                                </Button>
                                <Button 
                                    icon={<DownloadOutlined />} 
                                    style={{ 
                                        background: '#444', 
                                        border: '1px solid #666',
                                        borderRadius: '5px',
                                        color: 'white'
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                </Modal>

                {/* Add the Exception Modal */}
                <Modal
                    title={
                        <div style={{
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                            padding: '12px 24px',
                            backgroundColor: '#141414',
                            margin: '-20px -24px 20px',
                            borderTopLeftRadius: '8px',
                            borderTopRightRadius: '8px',
                            color: '#fff',
                            borderBottom: '1px solid #303030'
                        }}>
                            <span>Exception</span>
                            <div style={{ display: 'flex', gap: '16px' }}>
                                <Button 
                                    style={{
                                        backgroundColor: '#141414',
                                        color: '#fff',
                                        border: '1px solid #303030'
                                    }}
                                >
                                    Report Issue
                                </Button>
                                <Button 
                                    style={{
                                        backgroundColor: '#141414',
                                        color: '#fff',
                                        border: '1px solid #303030'
                                    }}
                                >
                                    Save
                                </Button>
                            </div>
                        </div>
                    }
                    open={exceptionModalVisible}
                    onCancel={() => setExceptionModalVisible(false)}
                    footer={null}
                    width={800}
                    centered
                    bodyStyle={{
                        backgroundColor: '#1f1f1f',
                        padding: '20px',
                        color: '#fff'
                    }}
                    style={{
                        backgroundColor: '#1f1f1f'
                    }}
                    maskStyle={{
                        backgroundColor: 'rgba(0, 0, 0, 0.6)'
                    }}
                >
                    <div style={{
                        backgroundColor: '#141414',
                        padding: '20px',
                        borderRadius: '4px',
                        marginBottom: '20px',
                        border: '1px solid #303030'
                    }}>
                        <p style={{ color: '#fff', marginBottom: '20px' }}>
                            An unhandled exception occurred. Please report the problem using the error reporting dialog or raise the issue to github.com/osdag-admin/Osdag.
                        </p>
                        
                        <div style={{ marginTop: '20px' }}>
                            <h4 style={{ color: '#fff', marginBottom: '10px' }}>Error information:</h4>
                            <div style={{ 
                                borderTop: '1px solid #303030',
                                marginTop: '10px',
                                paddingTop: '10px',
                                color: '#fff'
                            }}>
                                {new Date().toISOString().split('T')[0]}, {new Date().toLocaleTimeString()}
                            </div>
                            <div style={{ 
                                borderTop: '1px solid #303030',
                                marginTop: '10px',
                                paddingTop: '10px',
                                color: '#fff'
                            }}>
                                {'<class \'FileNotFoundError\'>:'}
                                [Errno 2] No such file or directory: 'ResourceFiles/design_example/_build/html'
                            </div>
                            <div style={{
                                marginTop: '20px',
                                display: 'flex',
                                alignItems: 'center',
                                gap: '10px',
                                color: '#faad14'
                            }}>
                                <span>^^^^^^^^^^^^^^^^^^^^^</span>
                            </div>
                        </div>
                    </div>
                </Modal>

                {/* Add the Video Tutorials Modal */}
                <Modal
                    title={
                        <div style={{
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                            padding: '12px 24px',
                            backgroundColor: '#141414',
                            margin: '-20px -24px 20px',
                            borderTopLeftRadius: '8px',
                            borderTopRightRadius: '8px',
                            color: '#fff',
                            borderBottom: '1px solid #303030'
                        }}>
                            <span>Tutorials</span>
                        </div>
                    }
                    open={tutorialsModalVisible}
                    onCancel={() => setTutorialsModalVisible(false)}
                    footer={null}
                    width={800}
                    centered
                    bodyStyle={{
                        backgroundColor: '#1f1f1f',
                        padding: '20px',
                        color: '#fff'
                    }}
                    style={{
                        backgroundColor: '#1f1f1f'
                    }}
                    maskStyle={{
                        backgroundColor: 'rgba(0, 0, 0, 0.6)'
                    }}
                >
                    <div style={{
                        backgroundColor: '#141414',
                        padding: '20px',
                        borderRadius: '4px',
                        marginBottom: '20px',
                        border: '1px solid #303030'
                    }}>
                        <p style={{ color: '#fff', marginBottom: '20px' }}>
                            Please visit:
                        </p>
                        
                        <div style={{ marginTop: '20px' }}>
                            <a 
                                href="https://www.youtube.com/channel/" 
                                target="_blank" 
                                rel="noopener noreferrer"
                                style={{ 
                                    color: '#1890ff',
                                    display: 'block',
                                    marginBottom: '15px',
                                    textDecoration: 'none'
                                }}
                            >
                                https://www.youtube.com/channel/
                            </a>
                            <a 
                                href="https://osdag.fossee.in/resources/videos" 
                                target="_blank" 
                                rel="noopener noreferrer"
                                style={{ 
                                    color: '#1890ff',
                                    display: 'block',
                                    textDecoration: 'none'
                                }}
                            >
                                https://osdag.fossee.in/resources/videos
                            </a>
                        </div>
                    </div>
                </Modal>

                {/* Add the About Osdag Modal */}
                <Modal
                    title={
                        <div style={{
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                            padding: '12px 24px',
                            backgroundColor: '#141414',
                            margin: '-20px -24px 20px',
                            borderTopLeftRadius: '8px',
                            borderTopRightRadius: '8px',
                            color: '#fff',
                            borderBottom: '1px solid #303030'
                        }}>
                            <span>About Osdag</span>
                        </div>
                    }
                    open={aboutModalVisible}
                    onCancel={() => setAboutModalVisible(false)}
                    footer={null}
                    width={800}
                    centered
                    bodyStyle={{
                        backgroundColor: '#1f1f1f',
                        padding: '20px',
                        color: '#fff'
                    }}
                    style={{
                        backgroundColor: '#1f1f1f'
                    }}
                    maskStyle={{
                        backgroundColor: 'rgba(0, 0, 0, 0.6)'
                    }}
                >
                    <div style={{
                        backgroundColor: '#141414',
                        padding: '20px',
                        borderRadius: '4px',
                        border: '1px solid #303030'
                    }}>
                        <div style={{ marginBottom: '20px', display: 'flex', alignItems: 'flex-start' }}>
                            <div style={{ flex: '0 0 80px', marginRight: '20px' }}>
                                <img 
                                    src="/path/to/osdag-logo.png" 
                                    alt="Osdag Logo" 
                                    style={{ width: '100%' }}
                                />
                            </div>
                            <div style={{ flex: 1 }}>
                                <h1 style={{ 
                                    color: '#fff', 
                                    fontSize: '36px', 
                                    margin: '0',
                                    fontWeight: 'normal'
                                }}>
                                    Osdag
                                </h1>
                                <h2 style={{ 
                                    color: '#fff', 
                                    fontSize: '24px',
                                    margin: '10px 0 0 0',
                                    fontWeight: 'normal'
                                }}>
                                    Open steel design and graphics
                                </h2>
                            </div>
                        </div>

                        <div style={{ color: '#fff', fontSize: '14px', lineHeight: '1.6' }}>
                            <p style={{ marginBottom: '15px' }}>
                                <strong>Osdag©</strong><br />
                                <strong>Version: 2025.01.a.2</strong>
                            </p>

                            <p style={{ marginBottom: '15px' }}>
                                Osdag is a cross-platform, free, and open-source software for the design and detailing of steel structures, following the Indian Standard IS:800-2007. Osdag is primarily built using Python other Python-based FOSS tools, such as, PyQt, OpenCascade, PythonOCC, SQLite. It allows the user to design steel connections, members and systems using a graphical user interface. The interactive GUI provides a 3D visualisation of the designed component and an option to export the CAD model to any drafting software for the creation of construction/fabrication drawings. The design is typically optimised following industry best practices. Osdag is developed by the Osdag team at IIT Bombay under the initiative of FOSSEE funded by the Ministry of Education (MoE), Government of India.
                            </p>

                            <p style={{ marginBottom: '15px' }}>
                                This version of Osdag contains the Shear Connection modules, Moment Connection modules and the Tension Member modules.
                            </p>

                            <p style={{ marginBottom: '15px' }}>
                                © Copyright Osdag contributors 2017.<br />
                                This program comes with ABSOLUTELY NO WARRANTY. This is a free software, and you are welcome to redistribute it under certain conditions. See the License.txt file for details regarding the license.
                            </p>

                            <p style={{ marginBottom: '15px' }}>
                                Authors: Osdag Team <a href="https://osdag.fossee.in/team" target="_blank" rel="noopener noreferrer" style={{ color: '#1890ff' }}>https://osdag.fossee.in/team</a><br />
                                Visit <a href="https://osdag.fossee.in" target="_blank" rel="noopener noreferrer" style={{ color: '#1890ff' }}>https://osdag.fossee.in</a> for more information.<br />
                                ------------------------------------------------------
                            </p>

                            <p style={{ color: '#999' }}>
                                Osdag® and the Osdag logo are registered trademarks of Indian Institute of Technology Bombay (IIT Bombay).
                            </p>
                        </div>
                    </div>
                </Modal>

                {/* Add the Ask Us a Question Modal */}
                <Modal
                    title={
                        <div style={{
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                            padding: '12px 24px',
                            backgroundColor: '#141414',
                            margin: '-20px -24px 20px',
                            borderTopLeftRadius: '8px',
                            borderTopRightRadius: '8px',
                            color: '#fff',
                            borderBottom: '1px solid #303030'
                        }}>
                            <span>Ask Us a Question</span>
                        </div>
                    }
                    open={askQuestionModalVisible}
                    onCancel={() => setAskQuestionModalVisible(false)}
                    footer={null}
                    width={800}
                    centered
                    bodyStyle={{
                        backgroundColor: '#1f1f1f',
                        padding: '20px',
                        color: '#fff'
                    }}
                    style={{
                        backgroundColor: '#1f1f1f'
                    }}
                    maskStyle={{
                        backgroundColor: 'rgba(0, 0, 0, 0.6)'
                    }}
                >
                    <div style={{
                        backgroundColor: '#141414',
                        padding: '20px',
                        borderRadius: '4px',
                        marginBottom: '20px',
                        border: '1px solid #303030'
                    }}>
                        <p style={{ color: '#fff', marginBottom: '20px' }}>
                            Please visit:
                        </p>
                        
                        <div style={{ marginTop: '20px' }}>
                            <a 
                                href="https://osdag.fossee.in/forum" 
                                target="_blank" 
                                rel="noopener noreferrer"
                                style={{ 
                                    color: '#1890ff',
                                    display: 'block',
                                    textDecoration: 'none'
                                }}
                            >
                                https://osdag.fossee.in/forum
                            </a>
                        </div>
                    </div>
                </Modal>
        </Layout>
        </ConfigProvider>
    );
};

export default ColumnCoverPlateBolted; 