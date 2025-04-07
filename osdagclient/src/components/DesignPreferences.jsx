import React, { useState } from 'react';
import { Tabs, Form, Select, Input, Button, Table, Row, Col, Space, Card, Alert, Typography, Divider, Upload, InputNumber } from 'antd';
import { SaveOutlined, ReloadOutlined, PlusOutlined, ClearOutlined, ImportOutlined, DownloadOutlined } from '@ant-design/icons';

const { TabPane } = Tabs;
const { Option } = Select;
const { Text, Title } = Typography;

const DesignPreferences = ({ visible, onCancel, onSave, initialValues }) => {
  const [form] = Form.useForm();
  const [activeTab, setActiveTab] = useState('bolt');
  const [clearance, setClearance] = useState(5);
  const [tolerance, setTolerance] = useState(5);

  // Handle tab change
  const handleTabChange = (key) => {
    setActiveTab(key);
  };

  // Handle form submission
  const handleSubmit = () => {
    form.validateFields().then(values => {
      onSave(values);
    }).catch(error => {
      console.log('Validation failed:', error);
    });
  };

  // Handle reset to defaults
  const handleDefaults = () => {
    form.resetFields();
  };

  // Bolt tab slip factor reference table data
  const slipFactorColumns = [
    {
      title: 'No.',
      dataIndex: 'no',
      key: 'no',
      width: '5%',
    },
    {
      title: 'Treatment of Surfaces',
      dataIndex: 'treatment',
      key: 'treatment',
      width: '75%',
    },
    {
      title: 'μ_f',
      dataIndex: 'factor',
      key: 'factor',
      width: '20%',
    },
  ];

  const slipFactorData = [
    {
      key: '1',
      no: 'i)',
      treatment: 'Surfaces not treated',
      factor: '0.2',
    },
    {
      key: '2',
      no: 'ii)',
      treatment: 'Surfaces blasted with short or grit and any loose rust removed, no pitting',
      factor: '0.5',
    },
    {
      key: '3',
      no: 'iii)',
      treatment: 'Surfaces blasted with short or grit and hot-dip galvanized',
      factor: '0.1',
    },
    {
      key: '4',
      no: 'iv)',
      treatment: 'Surfaces blasted with short or grit and spray-metallized with zinc (thickness 50–70 μm)',
      factor: '0.25',
    },
    {
      key: '5',
      no: 'v)',
      treatment: 'Surfaces blasted with shot or grit and painted with ethylzinc silicate coat (30–60 μm)',
      factor: '0.3',
    },
    {
      key: '6',
      no: 'vi)',
      treatment: 'Sand blasted surface, after light rusting',
      factor: '0.52',
    },
    {
      key: '7',
      no: 'vii)',
      treatment: 'Surfaces blasted with shot or grit and painted with ethylzinc silicate coat (60–80 μm)',
      factor: '0.3',
    },
    {
      key: '8',
      no: 'viii)',
      treatment: 'Surfaces blasted and painted with alcalizinc silicate coat',
      factor: '0.3',
    },
    {
      key: '9',
      no: 'ix)',
      treatment: 'Spray metallized with aluminium (>50 μm)',
      factor: '0.5',
    },
    {
      key: '10',
      no: 'x)',
      treatment: 'Clean mill scale',
      factor: '0.33',
    },
    {
      key: '11',
      no: 'xi)',
      treatment: 'Sand blasted surface',
      factor: '0.48',
    },
    {
      key: '12',
      no: 'xii)',
      treatment: 'Red lead painted surface',
      factor: '0.1',
    },
  ];

  // I-beam SVG diagram for the Beam Section tab
  const IBeamDiagram = () => (
    <div style={{ textAlign: 'center', marginTop: '20px' }}>
      <svg width="300" height="300" viewBox="0 0 300 300">
        {/* Flange and web outlines */}
        <path d="M50,50 L250,50 L245,65 L205,65 L205,235 L245,235 L250,250 L50,250 L55,235 L95,235 L95,65 L55,65 Z" 
          fill="none" stroke="black" strokeWidth="2" />
        
        {/* Dimension Lines */}
        {/* Width B */}
        <line x1="30" y1="50" x2="30" y2="250" stroke="#333" strokeWidth="1" />
        <line x1="270" y1="50" x2="270" y2="250" stroke="#333" strokeWidth="1" />
        <line x1="30" y1="40" x2="270" y2="40" stroke="#333" strokeWidth="1" strokeDasharray="5,5" />
        <text x="150" y="35" textAnchor="middle" fontSize="12">B</text>
        
        {/* Depth D */}
        <line x1="30" y1="40" x2="30" y2="260" stroke="#333" strokeWidth="1" strokeDasharray="5,5" />
        <line x1="20" y1="50" x2="20" y2="250" stroke="#333" strokeWidth="1" />
        <text x="10" y="150" textAnchor="middle" fontSize="12" transform="rotate(-90, 10, 150)">D</text>
        
        {/* Flange Thickness T */}
        <line x1="280" y1="50" x2="280" y2="65" stroke="#333" strokeWidth="1" />
        <text x="290" y="57" textAnchor="start" fontSize="12">T</text>
        <line x1="280" y1="235" x2="280" y2="250" stroke="#333" strokeWidth="1" />
        <text x="290" y="242" textAnchor="start" fontSize="12">T</text>
        
        {/* Web Thickness t */}
        <line x1="95" y1="260" x2="205" y2="260" stroke="#333" strokeWidth="1" />
        <text x="150" y="275" textAnchor="middle" fontSize="12">t</text>
        
        {/* Flange Slope α */}
        <path d="M245,65 A20,20 0 0 1 235,75" stroke="#333" fill="none" />
        <text x="260" y="85" textAnchor="start" fontSize="12">α</text>
        
        {/* Root Radius R1 */}
        <path d="M205,65 A8,8 0 0 1 195,73" stroke="#333" fill="none" />
        <text x="190" y="80" textAnchor="end" fontSize="12">R1</text>
        
        {/* Toe Radius R2 */}
        <path d="M245,65 A5,5 0 0 0 240,60" stroke="#333" fill="none" />
        <text x="235" y="55" textAnchor="end" fontSize="12">R2</text>
        
        {/* Axis System */}
        <line x1="150" y1="30" x2="150" y2="270" stroke="#666" strokeWidth="1" strokeDasharray="3,3" />
        <line x1="30" y1="150" x2="270" y2="150" stroke="#666" strokeWidth="1" strokeDasharray="3,3" />
        <text x="160" y="270" textAnchor="start" fontSize="12">Y-Y</text>
        <text x="270" y="160" textAnchor="start" fontSize="12">Z-Z</text>
        
        {/* Radii of Gyration */}
        <text x="130" y="165" textAnchor="end" fontSize="10">rz</text>
        <text x="165" y="130" textAnchor="start" fontSize="10">ry</text>
      </svg>
    </div>
  );

  return (
    <div style={{ 
      width: '100%', 
      height: '100%', 
      padding: '20px',
      backgroundColor: '#f5f5f5',
      borderRadius: '5px',
      position: 'relative'
    }}>
      <Title level={4} style={{ marginBottom: '20px' }}>Design Preferences</Title>
      
      <Tabs activeKey={activeTab} onChange={handleTabChange} type="card">
        <TabPane tab="Beam Section" key="beam">
          <Form
            form={form}
            layout="vertical"
            initialValues={{
              material: 'E 165 (Fe 290)',
              type: 'Rolled',
              source: 'Custom',
              modulus: 200,
              rigidity: 76.9,
              poisson: 0.3,
              thermal: '12 × 10⁻⁶',
              ...initialValues?.beam
            }}
          >
            <Row gutter={24}>
              {/* Left Panel - Mechanical Properties */}
              <Col span={10}>
                <Card title="Mechanical Properties" bordered={false}>
                  <Form.Item
                    name="designation"
                    label="Designation"
                  >
                    <Input placeholder="Enter section designation" />
                  </Form.Item>
                  
                  <Form.Item
                    name="material"
                    label="Material"
                    rules={[{ required: true, message: 'Please select material' }]}
                  >
                    <Select>
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
                  </Form.Item>
                  
                  <Form.Item
                    name="ultimate"
                    label="Ultimate Strength, Fu (MPa)"
                  >
                    <InputNumber style={{ width: '100%' }} />
                  </Form.Item>
                  
                  <Form.Item
                    name="yield"
                    label="Yield Strength, Fy (MPa)"
                  >
                    <InputNumber style={{ width: '100%' }} />
                  </Form.Item>
                  
                  <Form.Item
                    name="modulus"
                    label="Modulus of Elasticity, E (GPa)"
                  >
                    <InputNumber style={{ width: '100%' }} defaultValue={200} />
                  </Form.Item>
                  
                  <Form.Item
                    name="rigidity"
                    label="Modulus of Rigidity, G (GPa)"
                  >
                    <InputNumber style={{ width: '100%' }} defaultValue={76.9} />
                  </Form.Item>
                  
                  <Form.Item
                    name="poisson"
                    label="Poisson's Ratio, ν"
                  >
                    <InputNumber style={{ width: '100%' }} defaultValue={0.3} />
                  </Form.Item>
                  
                  <Form.Item
                    name="thermal"
                    label="Thermal Expansion Coefficient (/°C)"
                  >
                    <Input defaultValue="12 × 10⁻⁶" />
                  </Form.Item>
                  
                  <Form.Item
                    name="type"
                    label="Type"
                  >
                    <Select>
                      <Option value="Rolled">Rolled</Option>
                      <Option value="Built-up">Built-up</Option>
                      <Option value="Welded">Welded</Option>
                      <Option value="Formed">Formed</Option>
                    </Select>
                  </Form.Item>
                  
                  <Form.Item
                    name="source"
                    label="Source"
                  >
                    <Input defaultValue="Custom" />
                  </Form.Item>
                </Card>
              </Col>
              
              {/* Right Panel - Dimensions and Section Properties */}
              <Col span={14}>
                <Row>
                  <Col span={12}>
                    <Card title="Dimensions" bordered={false}>
                      <Form.Item
                        name="depth"
                        label="Depth, D (mm)"
                        rules={[{ required: true, message: 'Please enter depth' }]}
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="flangeWidth"
                        label="Flange Width, B (mm)"
                        rules={[{ required: true, message: 'Please enter flange width' }]}
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="flangeThickness"
                        label="Flange Thickness, T (mm)"
                        rules={[{ required: true, message: 'Please enter flange thickness' }]}
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="webThickness"
                        label="Web Thickness, t (mm)"
                        rules={[{ required: true, message: 'Please enter web thickness' }]}
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="flangeSlope"
                        label="Flange Slope, α (deg)"
                        rules={[{ required: true, message: 'Please enter flange slope' }]}
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="rootRadius"
                        label="Root Radius, R1 (mm)"
                        rules={[{ required: true, message: 'Please enter root radius' }]}
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="toeRadius"
                        label="Toe Radius, R2 (mm)"
                        rules={[{ required: true, message: 'Please enter toe radius' }]}
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                    </Card>
                  </Col>
                  <Col span={12}>
                    <Card title="Section Properties" bordered={false}>
                      <Form.Item
                        name="mass"
                        label="Mass, M (Kg/m)"
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="area"
                        label="Sectional Area, a (cm²)"
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="momentZ"
                        label="2nd Moment of Area, Iz (cm⁴)"
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="momentY"
                        label="2nd Moment of Area, Iy (cm⁴)"
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="radiusZ"
                        label="Radius of Gyration, rz (cm)"
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="radiusY"
                        label="Radius of Gyration, ry (cm)"
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                    </Card>
                  </Col>
                </Row>
                
                <Row style={{ marginTop: '20px' }}>
                  <Col span={12}>
                    <Card title="Section Properties - Plastic & Torsion" bordered={false}>
                      <Form.Item
                        name="plasticZ"
                        label="Plastic Modulus, Zzz (cm³)"
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="plasticY"
                        label="Plastic Modulus, Zyy (cm³)"
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                      
                      <Form.Item
                        name="torsion"
                        label="Torsion Constant, It (cm⁴)"
                      >
                        <InputNumber style={{ width: '100%' }} />
                      </Form.Item>
                    </Card>
                  </Col>
                  <Col span={12}>
                    <IBeamDiagram />
                  </Col>
                </Row>
              </Col>
            </Row>
            
            <div style={{ marginTop: '20px', display: 'flex', justifyContent: 'space-between', gap: '10px' }}>
              <Button 
                icon={<PlusOutlined />} 
              >
                Add
              </Button>
              <Button 
                icon={<ClearOutlined />} 
              >
                Clear
              </Button>
              <Button 
                icon={<ImportOutlined />} 
              >
                Import xlsx file
              </Button>
              <Button 
                icon={<DownloadOutlined />} 
              >
                Download xlsx file
              </Button>
              <Button 
                icon={<ReloadOutlined />} 
                onClick={handleDefaults}
              >
                Defaults
              </Button>
              <Button 
                type="primary" 
                icon={<SaveOutlined />} 
                onClick={handleSubmit}
              >
                Save
              </Button>
            </div>
          </Form>
        </TabPane>
        
        <TabPane tab="Connector" key="connector">
          <Form
            form={form}
            layout="vertical"
            initialValues={{
              material: 'E 165 (Fe 290)',
              ultimateStrength: 290,
              yieldStrength0to20: 165,
              yieldStrength20to40: 165,
              yieldStrengthGreater40: 165,
              ...initialValues?.connector
            }}
          >
            <Row gutter={24}>
              <Col span={12} offset={6}>
                <Card title="Material Properties" bordered={false}>
                  <Form.Item
                    name="material"
                    label="Material"
                    rules={[{ required: true, message: 'Please select material' }]}
                  >
                    <Select>
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
                  </Form.Item>
                  
                  <Divider orientation="left">Strength Parameters (MPa)</Divider>
                  
                  <Form.Item
                    name="ultimateStrength"
                    label="Ultimate Strength, Fu"
                    tooltip="The maximum stress the material can withstand before failure"
                  >
                    <InputNumber style={{ width: '100%' }} defaultValue={290} />
                  </Form.Item>
                  
                  <Form.Item
                    name="yieldStrength0to20"
                    label="Yield Strength, Fy (0–20 mm)"
                    tooltip="For material thickness up to 20 mm"
                  >
                    <InputNumber style={{ width: '100%' }} defaultValue={165} />
                  </Form.Item>
                  
                  <Form.Item
                    name="yieldStrength20to40"
                    label="Yield Strength, Fy (20–40 mm)"
                    tooltip="For thickness between 20 mm to 40 mm"
                  >
                    <InputNumber style={{ width: '100%' }} defaultValue={165} />
                  </Form.Item>
                  
                  <Form.Item
                    name="yieldStrengthGreater40"
                    label="Yield Strength, Fy (>40 mm)"
                    tooltip="For thicknesses greater than 40 mm"
                  >
                    <InputNumber style={{ width: '100%' }} defaultValue={165} />
                  </Form.Item>
                  
                  <Alert
                    message="These values conform with IS 2062:2011 Fe 290 Grade E, which is a standard structural steel in India."
                    type="info"
                    showIcon
                    style={{ marginTop: '20px' }}
                  />
                </Card>
              </Col>
            </Row>
          </Form>
        </TabPane>
        
        <TabPane tab="Bolt" key="bolt">
          <Form
            form={form}
            layout="vertical"
            initialValues={{
              boltType: 'Pre-tensioned',
              holeType: 'Standard',
              slipFactor: '0.3',
              ...initialValues?.bolt
            }}
          >
            <Row gutter={24}>
              {/* Left Side Panel - Inputs */}
              <Col span={10}>
                <Card title="Inputs" bordered={false}>
                  <Form.Item
                    name="boltType"
                    label="Type"
                    rules={[{ required: true, message: 'Please select bolt type' }]}
                  >
                    <Select>
                      <Option value="Pre-tensioned">Pre-tensioned</Option>
                      <Option value="Non-pretensioned">Non-pretensioned</Option>
                      <Option value="Bearing Bolt">Bearing Bolt</Option>
                      <Option value="Friction Grip Bolt">Friction Grip Bolt</Option>
                    </Select>
                  </Form.Item>
                  
                  <Form.Item
                    name="holeType"
                    label="Hole Type"
                    rules={[{ required: true, message: 'Please select hole type' }]}
                  >
                    <Select>
                      <Option value="Standard">Standard</Option>
                      <Option value="Oversized">Oversized</Option>
                      <Option value="Slotted">Slotted</Option>
                    </Select>
                  </Form.Item>
                  
                  <Form.Item
                    name="slipFactor"
                    label="HSFG Bolt - Slip Factor (μ)"
                    rules={[{ required: true, message: 'Please select slip factor' }]}
                  >
                    <Select>
                      <Option value="0.2">0.2</Option>
                      <Option value="0.3">0.3</Option>
                      <Option value="0.33">0.33</Option>
                      <Option value="0.48">0.48</Option>
                      <Option value="0.5">0.5</Option>
                      <Option value="0.52">0.52</Option>
                    </Select>
                  </Form.Item>
                </Card>
                
                <Alert
                  message="NOTE: If slip is permitted under the design load, design the bolt as a bearing bolt and select corresponding bolt grade."
                  type="warning"
                  showIcon
                  style={{ marginTop: '20px' }}
                />
              </Col>
              
              {/* Right Side Panel - Description */}
              <Col span={14}>
                <Card 
                  title="IS 800 Table 20 Typical Average Values for Coefficient of Friction (μ)" 
                  bordered={false}
                  style={{ backgroundColor: '#1a1a1a', color: 'white' }}
                  headStyle={{ backgroundColor: '#1a1a1a', color: 'white', borderBottom: '1px solid #333' }}
                  bodyStyle={{ padding: '0' }}
                >
                  <Table 
                    columns={slipFactorColumns} 
                    dataSource={slipFactorData} 
                    pagination={false}
                    size="small"
                    style={{ 
                      backgroundColor: '#1a1a1a', 
                      color: 'white',
                      border: 'none'
                    }}
                    className="dark-table"
                  />
                </Card>
              </Col>
            </Row>
          </Form>
        </TabPane>
        
        <TabPane tab="Detailing" key="detailing">
          <Form
            form={form}
            layout="vertical"
            initialValues={{
              edgePreparation: 'Sheared or hand flame cut',
              clearance: 5,
              tolerance: 5,
              gap: 10,
              corrosiveExposure: 'No',
              ...initialValues?.detailing
            }}
          >
            <Row gutter={24}>
              {/* Left Panel - Inputs */}
              <Col span={10}>
                <Card title="Inputs" bordered={false}>
                  <Form.Item
                    name="edgePreparation"
                    label="Edge Preparation Method"
                    rules={[{ required: true, message: 'Please select edge preparation method' }]}
                  >
                    <Select>
                      <Option value="Sheared or hand flame cut">Sheared or hand flame cut</Option>
                      <Option value="Rolled, machine-flame cut, sawn and planed">Rolled, machine-flame cut, sawn and planed</Option>
                    </Select>
                  </Form.Item>
                  
                  <Form.Item
                    name="clearance"
                    label="Clearance (mm)"
                    tooltip="Base clearance value before adding tolerance"
                    rules={[{ required: true, message: 'Please enter clearance value' }]}
                  >
                    <InputNumber 
                      style={{ width: '100%' }} 
                      defaultValue={5}
                      onChange={(value) => {
                        setClearance(value);
                        form.setFieldsValue({ gap: value + tolerance });
                      }}
                    />
                  </Form.Item>

                  <Form.Item
                    name="tolerance"
                    label="Tolerance (mm)"
                    tooltip="Erection tolerance value"
                    rules={[{ required: true, message: 'Please enter tolerance value' }]}
                  >
                    <InputNumber 
                      style={{ width: '100%' }} 
                      defaultValue={5}
                      onChange={(value) => {
                        setTolerance(value);
                        form.setFieldsValue({ gap: clearance + value });
                      }}
                    />
                  </Form.Item>
                  
                  <Form.Item
                    name="gap"
                    label="Gap Between Beam and Support (mm)"
                    tooltip="Clearance plus erection tolerance"
                    rules={[{ required: true, message: 'Please enter gap value' }]}
                  >
                    <InputNumber 
                      style={{ width: '100%' }} 
                      defaultValue={10}
                      onChange={(value) => {
                        setClearance(value - tolerance);
                        form.setFieldsValue({ clearance: value - tolerance });
                      }}
                    />
                  </Form.Item>
                  
                  <Form.Item
                    name="corrosiveExposure"
                    label="Are the Members Exposed to Corrosive Influences?"
                    rules={[{ required: true, message: 'Please select exposure option' }]}
                  >
                    <Select>
                      <Option value="Yes">Yes</Option>
                      <Option value="No">No</Option>
                    </Select>
                  </Form.Item>
                  
                  <Alert
                    message="Explanation:"
                    description="If clearance is assumed as 5 mm, and tolerance is 5 mm → gap = 10 mm. Defaults often come from IS 7215 Clause 2.3.1."
                    type="info"
                    showIcon
                    style={{ marginTop: '20px' }}
                  />
                </Card>
              </Col>
              
              {/* Right Panel - Description */}
              <Col span={14}>
                <Card 
                  title="Design Reference" 
                  bordered={false}
                >
                  <Typography>
                    <Text>
                      The minimum edge and end distances from the centre of any hole to the nearest edge of a plate shall not be less than:
                    </Text>
                    <ul>
                      <li>
                        <Text strong>1.7 times the hole diameter</Text> in case of <Text strong>sheared or hand flame cut edges</Text>
                      </li>
                      <li>
                        <Text strong>1.5 times the hole diameter</Text> in case of <Text strong>rolled, machine-flame cut, sawn and planed edges</Text>
                      </li>
                    </ul>
                    <Text>(IS 800 - cl. 10. 2. 4. 2)</Text>
                    
                    <Divider />
                    
                    <Text>
                      This gap should include the tolerance value of 5mm or 1.5mm. So if the assumed clearance is 5mm, then the gap should be = 10mm (= 5mm {clearance} + 5mm {tolerance}) or if the assumed clearance is 1.5mm, then the gap should be = 3mm (= 1.5mm {clearance} + 1.5mm {tolerance}). These are the default gap values based on the site practice for convenience of erection and IS 7215, Clause 2.3.1. The gap value can also be zero based on the nature of connection where clearance is not required.
                    </Text>
                    
                    <Divider />
                    
                    <Text>
                      Specifying whether the members are exposed to corrosive influences, here, only affects the calculation of the maximum edge distance as per cl. 10.2.4.3
                    </Text>
                  </Typography>
                </Card>
              </Col>
            </Row>
          </Form>
        </TabPane>
        
        <TabPane tab="Design" key="design">
          <Form
            form={form}
            layout="vertical"
            initialValues={{
              designMethod: 'Limit State Design',
              ...initialValues?.design
            }}
          >
            <Row gutter={24}>
              {/* Left Panel - Inputs */}
              <Col span={10}>
                <Card title="Inputs" bordered={false}>
                  <Form.Item
                    name="designMethod"
                    label="Design Method"
                    rules={[{ required: true, message: 'Please select design method' }]}
                  >
                    <Select>
                      <Option value="Limit State Design">Limit State Design</Option>
                      <Option value="Limit State (Capacity based) Design">Limit State (Capacity based) Design</Option>
                      <Option value="Working Stress Design">Working Stress Design</Option>
                    </Select>
                  </Form.Item>
                </Card>
              </Col>
              
              {/* Right Panel - Description */}
              <Col span={14}>
                <Card 
                  title="Design Reference" 
                  bordered={false}
                >
                  <Typography>
                    <Text>
                      The design method determines the approach used for structural calculations:
                    </Text>
                    <ul>
                      <li>
                        <Text strong>Limit State Design:</Text> Based on the concept that a structure should satisfy both ultimate and serviceability limit states
                      </li>
                      <li>
                        <Text strong>Limit State (Capacity based) Design:</Text> Considers capacity design principles where hierarchy of failure modes is established
                      </li>
                      <li>
                        <Text strong>Working Stress Design:</Text> Traditional method based on allowable stress under service loads
                      </li>
                    </ul>
                  </Typography>
                </Card>
              </Col>
            </Row>
          </Form>
        </TabPane>
      </Tabs>
      
      <div style={{ marginTop: '20px', display: 'flex', justifyContent: 'center', gap: '10px' }}>
        <Button 
          icon={<ReloadOutlined />} 
          onClick={handleDefaults}
        >
          Defaults
        </Button>
        <Button 
          type="primary" 
          icon={<SaveOutlined />} 
          onClick={handleSubmit}
        >
          Save
        </Button>
      </div>
      
      <style>
        {`
          .dark-table {
            background-color: #1a1a1a;
            color: white;
          }
          .dark-table .ant-table {
            background-color: #1a1a1a;
            color: white;
          }
          .dark-table .ant-table-thead > tr > th {
            background-color: #333;
            color: white;
            border-bottom: 1px solid #444;
          }
          .dark-table .ant-table-tbody > tr > td {
            border-bottom: 1px solid #333;
            color: white;
          }
          .dark-table .ant-table-tbody > tr:hover > td {
            background-color: #2a2a2a;
          }
          .dark-table .ant-table-tbody > tr {
            background-color: #1a1a1a;
          }
          .dark-table .ant-empty-description {
            color: white;
          }
        `}
      </style>
    </div>
  );
};

export default DesignPreferences; 