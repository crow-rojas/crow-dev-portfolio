const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: {
          100: '#ffe4d6',
          200: '#ffc9ad',
          300: '#ffad85',
          400: '#ff925c',
          500: '#ff7733', // Main orange
          600: '#ff5c00',
          700: '#cc4a00',
          800: '#993800',
          900: '#662600',
        },
        dark: {
          800: '#1a1a1a',
          900: '#0a0a0a',
        }
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      height: {
        screen: '100dvh',
      },
      padding: {
        'safe': 'env(safe-area-inset-bottom)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ]
}
