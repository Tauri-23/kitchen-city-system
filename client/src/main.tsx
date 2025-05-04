import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { RouterProvider } from 'react-router-dom'
import router from './router'

import "./assets/css/global.css";
import "./assets/css/elements.css";
import { GeneralProvider } from './contexts/GeneralContext';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
		<GeneralProvider>
			<RouterProvider router={router}/>
		</GeneralProvider>
    </StrictMode>,
)
