Class {
	#name : 'LuiDropDownMenuItem',
	#superclass : 'LuiBaseMenuItem',
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'instance creation' }
LuiDropDownMenuItem class >> named: aComponentName label: aString [
	^ self new
		initializeNamed: aComponentName label: aString;
		yourself
]

{ #category : 'components' }
LuiDropDownMenuItem >> addMenuItem: aMenuItemComponent [
	self submenuComponent addComponent: aMenuItemComponent
]

{ #category : 'components - updating' }
LuiDropDownMenuItem >> assignInputIdToLabelForId [
	self labelComponent for: self checkboxComponent componentId
]

{ #category : 'components' }
LuiDropDownMenuItem >> checkboxComponent [
	^ self componentNamed: self checkboxComponentName
]

{ #category : 'component names' }
LuiDropDownMenuItem >> checkboxComponentName [
	^ self componentName , 'Checkbox'
]

{ #category : 'gt - views' }
LuiDropDownMenuItem >> gtViewTagName [
	^ ''
]

{ #category : 'initialize' }
LuiDropDownMenuItem >> initializeNamed: aComponentName label: aString [
	self initializeNamed: aComponentName , 'MenuItem'.
	self
		addComponent: ((LuiResponsiveNavigationMenuCheckbox named: self checkboxComponentName)
				cssClass: LuiCssClassesMap / #'submenu-toggle';
				yourself);
		addComponent: ((LuiLabel named: self labelComponentName)
				text: aString;
				cssClass: LuiCssClassesMap / #'arrow-label';
				yourself);
		addComponent: (LuiSubmenu named: self submenuComponentName)
]

{ #category : 'components' }
LuiDropDownMenuItem >> labelComponent [
	^ self componentNamed: self labelComponentName
]

{ #category : 'component names' }
LuiDropDownMenuItem >> labelComponentName [
	^ self componentName , 'Label'
]

{ #category : 'components' }
LuiDropDownMenuItem >> submenuComponent [
	^ self componentNamed: self submenuComponentName
]

{ #category : 'component names' }
LuiDropDownMenuItem >> submenuComponentName [
	^ self componentName , 'Submenu'
]
