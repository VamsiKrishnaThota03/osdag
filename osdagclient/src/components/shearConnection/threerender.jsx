import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader.js'
import { OrbitControls, useTexture, Html, Box, Cylinder } from '@react-three/drei'
import { useLoader, Canvas } from '@react-three/fiber';
import React, {useMemo, Suspense, useState, useEffect} from "react";
//import mdl from  

// Simple fallback model representing a column connection
const FallbackModel = () => {
  return (
    <group>
      {/* Column 1 */}
      <Box args={[1, 5, 1]} position={[0, -3, 0]}>
        <meshStandardMaterial color="gray" />
      </Box>
      
      {/* Column 2 */}
      <Box args={[1, 5, 1]} position={[0, 3, 0]}>
        <meshStandardMaterial color="gray" />
      </Box>
      
      {/* Connection plates */}
      <Box args={[1.5, 0.1, 1.5]} position={[0, 0.5, 0]}>
        <meshStandardMaterial color="red" />
      </Box>
      <Box args={[1.5, 0.1, 1.5]} position={[0, -0.5, 0]}>
        <meshStandardMaterial color="red" />
      </Box>
      
      {/* Bolts */}
      <Cylinder args={[0.2, 0.2, 0.3, 16]} position={[0.5, 0, 0.5]} rotation={[Math.PI/2, 0, 0]}>
        <meshStandardMaterial color="blue" />
      </Cylinder>
      <Cylinder args={[0.2, 0.2, 0.3, 16]} position={[-0.5, 0, 0.5]} rotation={[Math.PI/2, 0, 0]}>
        <meshStandardMaterial color="blue" />
      </Cylinder>
      <Cylinder args={[0.2, 0.2, 0.3, 16]} position={[0.5, 0, -0.5]} rotation={[Math.PI/2, 0, 0]}>
        <meshStandardMaterial color="blue" />
      </Cylinder>
      <Cylinder args={[0.2, 0.2, 0.3, 16]} position={[-0.5, 0, -0.5]} rotation={[Math.PI/2, 0, 0]}>
        <meshStandardMaterial color="blue" />
      </Cylinder>
    </group>
  );
};

function Model({ hasOutput = false, showMessage = true }) {
  const [hasError, setHasError] = useState(false);
  const [obj, setObj] = useState(null);

  useEffect(() => {
    // Only attempt to load the model if there's output available
    if (!hasOutput) {
      return;
    }

    // Try multiple possible file paths
    const possiblePaths = [
      "/output-obj.obj",
      "./output-obj.obj",
      "output-obj.obj",
      "../output-obj.obj",
      "../../output-obj.obj",
      `${process.env.PUBLIC_URL}/output-obj.obj`
    ];
    
    let loadSuccess = false;
    
    // Try each path in sequence
    const tryNextPath = (index) => {
      if (index >= possiblePaths.length || loadSuccess) {
        if (!loadSuccess) {
          console.error("Error loading 3D model: All paths failed");
          setHasError(true);
        }
        return;
      }
      
      const currentPath = possiblePaths[index];
      console.log(`Attempting to load 3D model from: ${currentPath}`);
      
      const loader = new OBJLoader();
      loader.load(
        currentPath,
        (loadedObj) => {
          console.log(`Successfully loaded 3D model from: ${currentPath}`);
          setObj(loadedObj);
          loadSuccess = true;
        },
        undefined,
        (error) => {
          console.error(`Failed to load 3D model from: ${currentPath}`, error);
          // Try the next path
          tryNextPath(index + 1);
        }
      );
    };
    
    tryNextPath(0);
  }, [hasOutput]);

  // If no output is available, show a message or just the axes
  if (!hasOutput) {
    return (
      <group>
        <axesHelper args={[200]}/>
        {showMessage && window.location.pathname.includes('ColumnCoverPlateBolted') && !window.location.pathname.includes('DesignPreferences') && (
          <Html position={[0, 0, 0]}>
            <div style={{ 
              backgroundColor: 'rgba(31, 31, 31, 0.9)',  // Dark background
              padding: '10px', 
              borderRadius: '5px',
              width: '200px',
              textAlign: 'center',
              color: '#fff',  // White text
              border: '1px solid #303030'  // Dark border
            }}>
              No design output available yet.<br/>
              Click the Design button to generate a 3D model.
            </div>
          </Html>
        )}
        <OrbitControls />
      </group>
    );
  }

  // If there was an error loading the model but we have output, show a fallback visualization
  if (hasError) {
    return (
      <group>
        <axesHelper args={[200]}/>
        <FallbackModel />
        <Html position={[0, 5, 0]}>
          <div style={{ 
            backgroundColor: 'rgba(31, 31, 31, 0.9)',  // Dark background
            padding: '10px', 
            borderRadius: '5px',
            color: '#ff8800',  // Keep warning color
            width: '200px',
            textAlign: 'center',
            border: '1px solid #303030'  // Dark border
          }}>
            Showing simplified model.<br/>
            Actual model file could not be loaded.
          </div>
        </Html>
        <OrbitControls />
      </group>
    );
  }

  if (!obj) {
    return (
      <group>
        <axesHelper args={[200]}/>
        <Html position={[0, 0, 0]}>
          <div style={{ 
            backgroundColor: 'rgba(31, 31, 31, 0.9)',  // Dark background
            padding: '10px', 
            borderRadius: '5px',
            width: '200px',
            textAlign: 'center',
            color: '#fff',  // White text
            border: '1px solid #303030'  // Dark border
          }}>
            Loading 3D model...
          </div>
        </Html>
        <OrbitControls />
      </group>
    );
  }

  const texture = useTexture("/texture.png");
  
  const geometry = useMemo(() => {
    let g;
    obj.traverse((c) => {
      if (c.type === "Mesh") {
        const _c = c ; 
        g = _c.geometry;
      }
    });
    return g;
  }, [obj]);
  
  return (
    <group name='scene'>
        <axesHelper args={[200]}/> 
        {geometry && (
          <mesh geometry={geometry} scale={0.008}>
            <meshPhysicalMaterial 
              attach="material" 
              color={'#FF0000'} 
              metalness={0.25} 
              roughness={0.1} 
              opacity={2.0} 
              transparent={true} 
              transmission={0.99} 
              clearcoat={1.0} 
              clearcoatRoughness={0.25}
            />
          </mesh>
        )}
        <OrbitControls />
    </group>
  );
}

// Update ThreeRender to pass showMessage to Model
const ThreeRender = ({ resetFlag, hasOutput = false, showMessage = true }) => {
  return (
    <div style={{ width: '100%', height: '100%', position: 'relative' }}>
      <Canvas style={{ background: '#141414' }}>  {/* Dark background for 3D viewer */}
        <ambientLight intensity={0.5} />
        <spotLight position={[10, 10, 10]} angle={0.15} penumbra={1} />
        <pointLight position={[-10, -10, -10]} />
        <Suspense fallback={
          <Html center>
            <div style={{ 
              backgroundColor: 'rgba(31, 31, 31, 0.9)',  // Dark background
              padding: '10px', 
              borderRadius: '5px',
              width: '200px',
              textAlign: 'center',
              color: '#fff',  // White text
              border: '1px solid #303030'  // Dark border
            }}>
              Loading 3D viewer...
            </div>
          </Html>
        }>
          <Model hasOutput={hasOutput} showMessage={showMessage} />
        </Suspense>
      </Canvas>
    </div>
  );
};

export default ThreeRender;