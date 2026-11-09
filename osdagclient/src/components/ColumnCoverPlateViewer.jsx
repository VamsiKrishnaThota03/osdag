import React from 'react';

/**
 * 3D view placeholder for the Column Cover Plate modules.
 *
 * The web app cannot render these models yet: CAD generation needs pythonOCC
 * and FreeCAD on the server, and the CAD endpoint is wired to the shear
 * connection modules only. Instead of drawing a fake model, this explains the
 * current state and points users to the design outputs.
 */
const boxStyle = {
    height: '100%',
    minHeight: '240px',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    padding: '24px',
    background: '#141414',
    color: '#d9d9d9',
    textAlign: 'center',
    lineHeight: 1.6,
};

const cardStyle = {
    maxWidth: '380px',
    border: '1px solid #303030',
    borderRadius: '8px',
    padding: '20px 24px',
    background: '#1f1f1f',
};

const ColumnCoverPlateViewer = ({ hasOutput = false, cadAvailable = false }) => (
    <div style={boxStyle} role="status" aria-live="polite">
        <div style={cardStyle}>
            <div style={{ fontWeight: 600, fontSize: '15px', color: '#fff', marginBottom: '8px' }}>
                3D model not available
            </div>
            {hasOutput ? (
                <div>
                    The design was calculated. See the output dock for plate sizes, bolt or weld
                    details and capacities.
                </div>
            ) : (
                <div>Enter the inputs and click <strong>Design</strong> to calculate the connection.</div>
            )}
            <div style={{ marginTop: '10px', fontSize: '12px', color: '#8c8c8c' }}>
                {cadAvailable
                    ? 'pythonOCC is installed, but 3D rendering for this module is not connected to the web viewer yet.'
                    : '3D rendering needs pythonOCC and FreeCAD on the server.'}
            </div>
        </div>
    </div>
);

export default ColumnCoverPlateViewer;
