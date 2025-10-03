import React from "react";

export default function ModalComponent({ isOpen, onClose, children }) {
    if (!isOpen) return null;

    return (
        <div
            className="fixed inset-0 bg-black/30 bg-opacity-50 flex justify-center items-center z-50 h-screen"
            onClick={onClose}
        >
            <div
                className="bg-white rounded-2xl shadow-xl p-6 w-11/12 max-w-md relative animate-fadeIn"
                onClick={(e) => e.stopPropagation()}
            >
                <button
                    className="absolute top-3 right-3 text-gray-600 hover:text-gray-900 text-2xl cursor-pointer"
                    onClick={onClose}
                >
                    &times;
                </button>
                {children}
            </div>
        </div>
    );
}

