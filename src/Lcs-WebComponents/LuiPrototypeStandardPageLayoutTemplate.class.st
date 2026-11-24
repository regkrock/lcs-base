Class {
	#name : 'LuiPrototypeStandardPageLayoutTemplate',
	#superclass : 'LuiStandardPageLayoutTemplate',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components - definition' }
LuiPrototypeStandardPageLayoutTemplate >> brandComponentDefinition [
	^ super brandComponentDefinition
		brandName: '';
		yourself
]

{ #category : 'as yet unclassified' }
LuiPrototypeStandardPageLayoutTemplate >> homeMenuItemComponentDefinition [
	| item |
	^ (item := LuiMenuItem named: 'homeMenuItem')
		cssClass: LuiCssClassesMap / #'nav-item';
		beButtonType;
		buttonLabel: 'Home';
		buttonOnClickExecute: [ item rootComponent switchMainComponentTo: self homePresenterDefinition]
			update: [ item rootComponent currentSwitchableComponent ]
			update: [ item rootComponent navigationBar ];
		title: 'Home Menu Item';
		yourself
]

{ #category : 'components - definition' }
LuiPrototypeStandardPageLayoutTemplate >> homePresenterDefinition [
	^ LuiMessagePresenter new
		componentName: 'homePresenter';
		message: 'Home';
		yourself
]

{ #category : 'as yet unclassified' }
LuiPrototypeStandardPageLayoutTemplate >> loginMenuItemComponentDefinition [
	| item |
	^ (item := LuiMenuItem named: 'loginMenuItem')
		cssClass: LuiCssClassesMap / #'nav-item';
		beButtonType;
		buttonLabel: 'Sign In';
		buttonOnClickExecute: [ item rootComponent switchMainComponentTo: self loginPresenterDefinition]
			update: [ item rootComponent currentSwitchableComponent ]
			update: [ item rootComponent navigationBar ];
		title: 'Home Menu Item';
		yourself
]

{ #category : 'components - definition' }
LuiPrototypeStandardPageLayoutTemplate >> loginPresenterDefinition [
	^ (LuiDiv named: 'loginWrapper')
		cssClass: LuiCssClassesMap / #loginWrapper;
		addComponent: (LuiLoginPresenter named: 'loginPresenter' model: LcsLoginProcess new);
		yourself
]

{ #category : 'as yet unclassified' }
LuiPrototypeStandardPageLayoutTemplate >> navigationMenuDefinition [
	^ super navigationMenuDefinition
		addComponent: self homeMenuItemComponentDefinition;
		addComponent: self loginMenuItemComponentDefinition;
		"addComponent: self contactSubenuComponentDefinition;
		addComponent: self aboutContactItemDefinition;
		addComponent: self socialMediaBarComponentDefinition;"
		yourself
]
