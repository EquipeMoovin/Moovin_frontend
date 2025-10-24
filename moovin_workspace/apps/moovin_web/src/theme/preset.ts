// preset.ts
import { definePreset } from '@primeuix/themes';
import Aura from '@primeuix/themes/aura';

const Preset = definePreset(Aura, {
  semantic: {
    // Paleta principal
    primary: {
      50: '#f3f7e3',
      100: '#e3efc0',
      200: '#d3e79d',
      300: '#c3df7a',
      400: '#b3d75f',
      500: '#97B52D', 
      600: '#7fa023',
      700: '#678b1a',
      800: '#507610',
      900: '#395107',
      950: '#2d3d05',
    },

    secondary: {
      50: '#e3e5f7',
      100: '#c0c5f0',
      200: '#9da5e8',
      300: '#7a85e0',
      400: '#5f6ed9',
      500: '#5c6bc0', 
      600: '#4f5aa9',
      700: '#434a92',
      800: '#36387b',
      900: '#292764',
      950: '#1f1d55',
    },

    success: {
      500: '#4caf50',
      hover: '#43a047',
      active: '#388e3c',
    },

    warning: {
      500: '#ff9800',
      hover: '#fb8c00',
      active: '#f57c00',
    },

    error: {
      500: '#f44336',
      hover: '#e53935',
      active: '#d32f2f',
    },

    // Superfícies (light/dark mode)
    colorScheme: {
      light: {
        surface: {
          0: '#ffffff',
          50: '#f4f4f4',
          100: '#eaeaea',
          200: '#e0e0e0',
          300: '#d6d6d6',
          400: '#cccccc',
          500: '#c2c2c2',
          600: '#b8b8b8',
          700: '#aeaeae',
          800: '#a4a4a4',
          900: '#9a9a9a',
          950: '#909090',
        },
        text: {
          primary: '#333333',
        },
      },
    },

    // Formulários
    form: {
      background: '#ffffff',
      border: '#cccccc',
      text: '#333333',
      placeholder: '#888888',
      disabled: '#e0e0e0',
      focusBorder: '#97B52D',
    },

    // Focus ring
    focusRing: {
      color: '#97B52D',
      width: '2px',
    },

    // Componentes
    component: {
      button: {
        background: '#97B52D',
        color: '#ffffff',
        hoverBackground: '#7fa023',
        hoverColor: '#ffffff',
        activeBackground: '#678b1a',
        activeColor: '#ffffff',
        disabledBackground: '#cccccc',
        disabledColor: '#888888',
      },
      card: {
        background: '#ffffff',
        border: '#cccccc',
        text: '#333333',
      },
      input: {
        background: '#ffffff',
        border: '#cccccc',
        text: '#333333',
        placeholder: '#888888',
        hoverBorder: '#97B52D',
        focusBorder: '#7fa023',
        disabledBackground: '#e0e0e0',
      },
      badge: {
        successBackground: '#4caf50',
        warningBackground: '#ff9800',
        errorBackground: '#f44336',
        color: '#ffffff',
      },
      toast: {
        successBackground: '#4caf50',
        warningBackground: '#ff9800',
        errorBackground: '#f44336',
        infoBackground: '#97B52D',
        color: '#ffffff',
      },
    },
    table: {
        header: {
          background: '#ffffff',
          color: '#333333',
          borderColor: '#cccccc',
        },
        row: {
          background: '#ffffff',
          color: '#333333',
          borderColor: '#e0e0e0',
          hoverBackground: '#f4f4f4',
          selectedBackground: '#97B52D',
          selectedColor: '#ffffff',
          stripedBackground: '#f9f9f9',
        },
        paginator: {
          background: '#ffffff',
          borderColor: '#cccccc',
          color: '#333333',
          buttonHoverBackground: '#e0e0e0',
        },
      },
  },
});

export default Preset;
