const path = require('path');
const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const config = {
    entry: {
        app: [
            './src/index.js',
        ],
    },

    output: {
        path: path.resolve(__dirname + '/dist'),
        filename: '[name].js',
    },

    module: {
        rules: [{
                test: /\.html$/,
                exclude: /node_modules/,
                loader: 'file-loader?name=[name].[ext]',
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/, /Stylesheets\.elm$/],
                loader: 'elm-webpack-loader?verbose=true&debug=true'
            },
            {
                test: /Stylesheets\.elm$/,
                use: [
                    'style-loader',
                    'css-loader',
                    'elm-css-webpack-loader'
                ]
            },
            {
                test: /\.css$/,
                use: [{
                        loader: 'style-loader'
                    },
                    {
                        loader: 'css-loader'
                    },
                ]
            }
        ],
    },

    plugins: [
        new CopyWebpackPlugin([
            { from: './public' }
        ])
    ],

    devServer: {
        inline: true,
        stats: { colors: true },
    },
};

module.exports = config;

