import React from 'react';
import Zoom from 'react-medium-image-zoom';
import 'react-medium-image-zoom/dist/styles.css';
import './UploadSuratJalanModal.css';

const ImageModal = ({ imageUrl, onClose }) => {
  return (
    <div className="image-modal" onClick={onClose}>
      <div className="image-modal-content" onClick={(e) => e.stopPropagation()}>
        <Zoom>
          <img src={imageUrl} alt="Zoomed" className="zoomable-image" />
        </Zoom>
      </div>
    </div>
  );
};

export default ImageModal;
