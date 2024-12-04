classdef mini_project_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        GridLayout             matlab.ui.container.GridLayout
        LeftPanel              matlab.ui.container.Panel
        GenerateButton         matlab.ui.control.Button
        InputSignalEditField   matlab.ui.control.EditField
        InputSignalLabel       matlab.ui.control.Label
        Label                  matlab.ui.control.Label
        CenterPanel            matlab.ui.container.Panel
        OutputSignalEditField  matlab.ui.control.EditField
        SaveOutputButton       simulink.ui.control.SaveOutputButton
        ClearOutputButton      matlab.ui.control.Button
        SignalAnalysisLabel    matlab.ui.control.Label
        UIAxes                 matlab.ui.control.UIAxes
        RightPanel             matlab.ui.container.Panel
        SignaltypeButtonGroup  matlab.ui.container.ButtonGroup
        DiscreteButton         matlab.ui.control.RadioButton
        PeriodicButton         matlab.ui.control.RadioButton
        GridSwitch             matlab.ui.control.Switch
        GridSwitchLabel        matlab.ui.control.Label
        AplitudeKnob           matlab.ui.control.Knob
        AplitudeKnobLabel      matlab.ui.control.Label
        FrequencySlider        matlab.ui.control.Slider
        FrequencySliderLabel   matlab.ui.control.Label
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end


    % Public properties that correspond to the Simulink model
    properties (Access = public, Transient)
        Simulation simulink.Simulation
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Value changing function: AplitudeKnob
        function AplitudeKnobValueChanging(app, event)
            A=event.Value;
            input_value=app.InputSignalEditField.Value;
            t=0:0.01:1;
            f=app.FrequencySlider.Value;
            if strcmp(input_value, 'Sin')
                sig=A*sin(2*pi*f*t);
                plot(app.UIAxes,t,sig);
                ylim(app.UIAxes,[-10 10]);
                app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
            elseif strcmp(input_value, 'Sawtooth')
                sig=A*sawtooth(2*pi*f*t);
                plot(app.UIAxes,t,sig);
                ylim(app.UIAxes,[-10 10]);
                app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
            elseif strcmp(input_value, 'Square')
                sig=A*square(2*pi*f*t);
                plot(app.UIAxes,t,sig);
                ylim(app.UIAxes,[-10 10]);
                app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
            elseif strcmp(input_value, 'Triangular')
                sig=A*sawtooth(2*pi*f*t, 0.5);
                plot(app.UIAxes,t,sig);
                ylim(app.UIAxes,[-10 10]);
                app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
            else
                app.OutputSignalEditField.Value = 'Error in Knob!';
            end
        end

        % Value changed function: GridSwitch
        function GridSwitchValueChanged(app, event)
            value = app.GridSwitch.Value;
            if strcmp(value, 'On')
                grid(app.UIAxes, "on");
                app.UIAxes.GridLineWidth = 2;
            else 
                grid(app.UIAxes, "off");
            end
        end

        % Button pushed function: GenerateButton
        function GenerateButtonPushed(app, event)
            input_value = app.InputSignalEditField.Value;
            A = app.AplitudeKnob.Value;
            t=0:0.01:1;
            f=app.FrequencySlider.Value;
            try
                if strcmp(input_value, 'Sin')
                    sig=A*sin(2*pi*f*t);
                    plot(app.UIAxes,t,sig);
                    ylim(app.UIAxes,[-10 10]);
                    app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
                elseif strcmp(input_value, 'Sawtooth')
                    sig=sawtooth(2*pi*f*t);
                    plot(app.UIAxes,t,sig);
                    ylim(app.UIAxes,[-10 10]);
                    app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
                elseif strcmp(input_value, 'Square')
                    sig=square(2*pi*f*t);
                    plot(app.UIAxes,t,sig);
                    ylim(app.UIAxes,[-10 10]);
                    app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
                elseif strcmp(input_value, 'Triangular')
                    sig=sawtooth(2*pi*f*t,0.5);
                    plot(app.UIAxes,t,sig);
                    ylim(app.UIAxes,[-10 10]);
                    app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
                else 
                    app.InputSignalEditField.Value = 'Error!';
                    app.OutputSignalEditField.Value = 'Error!';
                end
            catch
                app.InputSignalEditField.Value = 'Error!';
                app.OutputSignalEditField.Value = 'Error!';
            end
        end

        % Button pushed function: ClearOutputButton
        function ClearOutputButtonPushed(app, event)
            app.OutputSignalEditField.Value = '';
            cla(app.UIAxes);
        end

        % Value changing function: FrequencySlider
        function FrequencySliderValueChanging(app, event)
            input_value = app.InputSignalEditField.Value;
            f = event.Value;
            A=app.AplitudeKnob.Value;
            t=0:0.01:1;
            if strcmp(input_value, 'Sin')
                sig=A*sin(2*pi*f*t);
                plot(app.UIAxes,t,sig);
                ylim(app.UIAxes,[-10 10]);
                app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
            elseif strcmp(input_value, 'Sawtooth')
                sig=A*sawtooth(2*pi*f*t);
                plot(app.UIAxes,t,sig);
                ylim(app.UIAxes,[-10 10]);
                app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
            elseif strcmp(input_value, 'Square')
                sig=A*square(2*pi*f*t);
                plot(app.UIAxes,t,sig);
                ylim(app.UIAxes,[-10 10]);
                app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
            elseif strcmp(input_value, 'Triangular')
                sig=A*sawtooth(2*pi*f*t, 0.5);
                plot(app.UIAxes,t,sig);
                ylim(app.UIAxes,[-10 10]);
                app.OutputSignalEditField.Value = ['f ( t , f ) =', num2str(A) ,'* sin ( 2 * pi *', num2str(f) ,' * t )'];
            else
                app.OutputSignalEditField.Value = 'Error in Slider!';
            end
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {480, 480, 480};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {480, 480};
                app.GridLayout.ColumnWidth = {'1x', '1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = [1,2];
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 2;
            else
                % Change to a 1x3 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {220, '1x', 220};
                app.LeftPanel.Layout.Row = 1;
                app.LeftPanel.Layout.Column = 1;
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 2;
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 3;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 860 480];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {220, '1x', 220};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create Label
            app.Label = uilabel(app.LeftPanel);
            app.Label.FontSize = 14;
            app.Label.Position = [25 372 183 86];
            app.Label.Text = {'Different signal - Function'; 'Sinusoidal signal - Sin'; 'Sawtooth signal -  Sawtooth'; 'Square signal - Square'; 'Triangular signal - Triangular'};

            % Create InputSignalLabel
            app.InputSignalLabel = uilabel(app.LeftPanel);
            app.InputSignalLabel.HorizontalAlignment = 'right';
            app.InputSignalLabel.FontSize = 14;
            app.InputSignalLabel.Position = [14 312 44 34];
            app.InputSignalLabel.Text = {'Input '; 'Signal'};

            % Create InputSignalEditField
            app.InputSignalEditField = uieditfield(app.LeftPanel, 'text');
            app.InputSignalEditField.FontSize = 14;
            app.InputSignalEditField.Position = [67 310 145 39];

            % Create GenerateButton
            app.GenerateButton = uibutton(app.LeftPanel, 'push');
            app.GenerateButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateButtonPushed, true);
            app.GenerateButton.FontSize = 14;
            app.GenerateButton.Position = [47 234 130 36];
            app.GenerateButton.Text = 'Generate';

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.CenterPanel);
            title(app.UIAxes, 'Graph')
            xlabel(app.UIAxes, 'Time')
            ylabel(app.UIAxes, 'Signal')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.YLim = [0 10];
            app.UIAxes.Box = 'on';
            app.UIAxes.FontSize = 14;
            app.UIAxes.Position = [23 110 362 202];

            % Create SignalAnalysisLabel
            app.SignalAnalysisLabel = uilabel(app.CenterPanel);
            app.SignalAnalysisLabel.BackgroundColor = [0 1 1];
            app.SignalAnalysisLabel.HorizontalAlignment = 'center';
            app.SignalAnalysisLabel.FontSize = 36;
            app.SignalAnalysisLabel.Position = [32 391 357 57];
            app.SignalAnalysisLabel.Text = 'Signal Analysis';

            % Create ClearOutputButton
            app.ClearOutputButton = uibutton(app.CenterPanel, 'push');
            app.ClearOutputButton.ButtonPushedFcn = createCallbackFcn(app, @ClearOutputButtonPushed, true);
            app.ClearOutputButton.FontSize = 14;
            app.ClearOutputButton.Position = [58 19 91 73];
            app.ClearOutputButton.Text = {'Clear'; 'Output'};

            % Create SaveOutputButton
            app.SaveOutputButton = uisimdatabutton('saveoutput', app.CenterPanel);
            app.SaveOutputButton.FontSize = 14;
            app.SaveOutputButton.Position = [289 18 96 73];

            % Create OutputSignalEditField
            app.OutputSignalEditField = uieditfield(app.CenterPanel, 'text');
            app.OutputSignalEditField.FontSize = 14;
            app.OutputSignalEditField.Position = [32 334 352 39];
            app.OutputSignalEditField.Value = 'Output signal equation display here..';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;

            % Create FrequencySliderLabel
            app.FrequencySliderLabel = uilabel(app.RightPanel);
            app.FrequencySliderLabel.HorizontalAlignment = 'right';
            app.FrequencySliderLabel.Position = [13 289 62 22];
            app.FrequencySliderLabel.Text = 'Frequency';

            % Create FrequencySlider
            app.FrequencySlider = uislider(app.RightPanel);
            app.FrequencySlider.Limits = [0 10];
            app.FrequencySlider.ValueChangingFcn = createCallbackFcn(app, @FrequencySliderValueChanging, true);
            app.FrequencySlider.Position = [96 298 103 3];

            % Create AplitudeKnobLabel
            app.AplitudeKnobLabel = uilabel(app.RightPanel);
            app.AplitudeKnobLabel.HorizontalAlignment = 'center';
            app.AplitudeKnobLabel.Position = [87 122 48 22];
            app.AplitudeKnobLabel.Text = 'Aplitude';

            % Create AplitudeKnob
            app.AplitudeKnob = uiknob(app.RightPanel, 'continuous');
            app.AplitudeKnob.Limits = [0 10];
            app.AplitudeKnob.ValueChangingFcn = createCallbackFcn(app, @AplitudeKnobValueChanging, true);
            app.AplitudeKnob.Position = [79 168 63 63];

            % Create GridSwitchLabel
            app.GridSwitchLabel = uilabel(app.RightPanel);
            app.GridSwitchLabel.HorizontalAlignment = 'center';
            app.GridSwitchLabel.FontSize = 14;
            app.GridSwitchLabel.Position = [98 326 31 22];
            app.GridSwitchLabel.Text = 'Grid';

            % Create GridSwitch
            app.GridSwitch = uiswitch(app.RightPanel, 'slider');
            app.GridSwitch.ValueChangedFcn = createCallbackFcn(app, @GridSwitchValueChanged, true);
            app.GridSwitch.FontSize = 14;
            app.GridSwitch.Position = [95 347 36 16];

            % Create SignaltypeButtonGroup
            app.SignaltypeButtonGroup = uibuttongroup(app.RightPanel);
            app.SignaltypeButtonGroup.Title = 'Signal type';
            app.SignaltypeButtonGroup.FontSize = 14;
            app.SignaltypeButtonGroup.Position = [53 388 121 71];

            % Create PeriodicButton
            app.PeriodicButton = uiradiobutton(app.SignaltypeButtonGroup);
            app.PeriodicButton.Text = 'Periodic';
            app.PeriodicButton.FontSize = 14;
            app.PeriodicButton.Position = [10 23 72 22];
            app.PeriodicButton.Value = true;

            % Create DiscreteButton
            app.DiscreteButton = uiradiobutton(app.SignaltypeButtonGroup);
            app.DiscreteButton.Text = 'Discrete';
            app.DiscreteButton.FontSize = 14;
            app.DiscreteButton.Position = [10 -2 73 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = mini_project_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end