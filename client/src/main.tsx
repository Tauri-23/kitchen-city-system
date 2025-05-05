import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { RouterProvider } from 'react-router-dom'
import router from './router'

import "./assets/css/global.css";
import "./assets/css/elements.css";
import "./assets/css/navigations.css";


import 'react-toastify/dist/ReactToastify.css';


// BOOTSTRAP
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min";


import { GeneralProvider } from './contexts/GeneralContext';
import { LoggedUserProvider } from './contexts/LoggedUserContext';
import { ConfigProvider } from 'antd';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
		<ConfigProvider
		theme={{
			token: {
			  colorPrimary: '#FE8E02', // Change this to your preferred primary color
			},
		  }}
		>
			<GeneralProvider>
				<LoggedUserProvider>
					<RouterProvider router={router}/>
				</LoggedUserProvider>
			</GeneralProvider>
		</ConfigProvider>
    </StrictMode>,
)
