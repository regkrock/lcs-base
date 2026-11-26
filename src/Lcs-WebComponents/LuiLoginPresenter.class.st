Class {
	#name : 'LuiLoginPresenter',
	#superclass : 'LuiPresenter',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'building' }
LuiLoginPresenter >> buildComponents [
	self addComponent: (LuiDiv named: LuiCssClassesMap / #loginWrapper).
	self cssClass: LuiCssClassesMap / #loginForm.
	self 
		addComponent: ((LuiDiv named: 'signingMessage')
			cssClass: LuiCssClassesMap / #signinText;
			text: 'Sign in to SEAS';
			yourself);
		addComponent: ((LuiLabelWithInputComponent onSlotNamed: 'userId' model: self model)
				beVerticalDisplay;
				autocomplete: 'userId';
				yourself);
		addComponent: ((LuiLabelWithInputComponent onSlotNamed: 'password' model: self model)
				beVerticalDisplay;
				beCurrentPasswordAutocomplete;
				yourself);
		addComponent: ((LuiButton named: 'login')
				cssClass: LuiCssClassesMap / #loginButton;
				text: 'Login';
				serializeForm;
				execute: [ self model loginUser ] updating: #();
				yourself);
		addComponent: self newToSeasGroup.
	^ self
]

{ #category : 'building' }
LuiLoginPresenter >> createAnAccountMessagePresenter [
	^ LuiMessagePresenter new
		componentName: 'createAnAccount';
		message: 'Create An Account From';
		yourself
]

{ #category : 'building' }
LuiLoginPresenter >> newToSeasGroup [
	| item |
	(item := LuiDiv named: 'newToSeasMessageGroup')
			cssClass: LuiCssClassesMap / #'newToSeasMessageGroup';
			addComponent: (
				(LuiDiv named: 'newToSeasMessage')
					text: 'New to SEAS Monmout? ';
					yourself);
			addComponent: (
				(LuiAnchor named: 'createAnAccountAnchor')
					url: '#';
					text: 'Create an account';
					onClickExecute: [ item rootComponent switchMainComponentTo: self createAnAccountMessagePresenter ] 
						update: [ item rootComponent currentSwitchableComponent ]
						update: [ item rootComponent navigationBar ];
					yourself).
	^ item
]
