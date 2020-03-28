function varargout = first_adder_gui(varargin)
% FIRST_ADDER_GUI MATLAB code for first_adder_gui.fig
%      FIRST_ADDER_GUI, by itself, creates a new FIRST_ADDER_GUI or raises the existing
%      singleton*.
%
%      H = FIRST_ADDER_GUI returns the handle to a new FIRST_ADDER_GUI or the handle to
%      the existing singleton*.
%
%      FIRST_ADDER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRST_ADDER_GUI.M with the given input arguments.
%
%      FIRST_ADDER_GUI('Property','Value',...) creates a new FIRST_ADDER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before first_adder_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to first_adder_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help first_adder_gui

% Last Modified by GUIDE v2.5 01-May-2016 15:36:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @first_adder_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @first_adder_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before first_adder_gui is made visible.
function first_adder_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to first_adder_gui (see VARARGIN)

% Choose default command line output for first_adder_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes first_adder_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = first_adder_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function input1_Callback(hObject, eventdata, handles)
% hObject    handle to input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input1 as text
%        str2num(get(hObject,'String')) returns contents of input1 as a double
input1 = str2num(get(hObject,'String'));   % get first input from the user's typing
if (isempty(input1) == 1)
    set(hObject,'String','0');        % make sure that a valid number is input by the user
end
guidata(hObject, handles);    % after user has typed in their number, mupdate the handle for the input1 object and 
                               % the user data handle

% --- Executes during object creation, after setting all properties.
function input1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input2_Callback(hObject, eventdata, handles)
% hObject    handle to input2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input2 as text
%        str2num(get(hObject,'String')) returns contents of input2 as a double
input2 = str2num(get(hObject,'String'));     % get first input from the user's typing
if (isempty(input2) == 1)
    set(hObject,'String','0');        % make sure that a valid number is input by the user
end
guidata(hObject, handles);            % after user has typed in their number, mupdate the handle for the input2 object and
                                      % the user data handle

% --- Executes during object creation, after setting all properties.
function input2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_button.
function add_button_Callback(hObject, eventdata, handles)
% hObject    handle to add_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = get(handles.input1, 'String');         %grab the data from the input1 and input2 sub-objects. 
B = get(handles.input2, 'String');         % (they are coming in as strings)

A = str2num(A);                  % convert the input1 and input2 string objects to numbers for adding
B = str2num(B);

sum = A + B;                      % compute the sum
sum1 = num2str(sum);              % convert the sum to a string for output

set(handles.sum_ans,'String',sum1);   % set the answer sub-object to the sum-string
guidata(hObject, handles);         % update the handles for the push button object and the user data handles
