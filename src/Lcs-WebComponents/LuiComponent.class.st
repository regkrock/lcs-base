Class {
	#name : #LuiComponent,
	#superclass : #WAComponent,
	#instVars : [
		'components',
		'cssClasses',
		'domainObject',
		'parentComponent',
		'componentId'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'instance creation' }
LuiComponent class >> on: aWebComponent [
	^ self new 
		initializeOn: aWebComponent;
		yourself
]

{ #category : #accessing }
LuiComponent >> componentId [
	^ componentId
]

{ #category : #accessing }
LuiComponent >> componentId: anObject [
	componentId := anObject
]

{ #category : #accessing }
LuiComponent >> components [
	^ components
]

{ #category : #accessing }
LuiComponent >> components: anObject [
	components := anObject
]

{ #category : #accessing }
LuiComponent >> cssClasses [
	^ cssClasses
]

{ #category : #accessing }
LuiComponent >> cssClasses: anObject [
	cssClasses := anObject
]

{ #category : #styling }
LuiComponent >> cssClassesString [
	^ self cssClasses cssClassesString
]

{ #category : #rendering }
LuiComponent >> displayValue [
	^ self domainObject ifNil: [ '' ] displayString
]

{ #category : #accessing }
LuiComponent >> domainObject [
	^ domainObject
]

{ #category : #accessing }
LuiComponent >> domainObject: anObject [
	domainObject := anObject
]

{ #category : #initialize }
LuiComponent >> initialize [
	super initialize.
	self components: OrderedDictionary new.
	self cssClasses: LuiCssClasses new.
]

{ #category : #initialize }
LuiComponent >> initializeOn: aWebComponent [ 
	self parentComponent: aWebComponent
]

{ #category : #accessing }
LuiComponent >> parentComponent [
	^ parentComponent
]

{ #category : #accessing }
LuiComponent >> parentComponent: anObject [
	parentComponent := anObject
]

{ #category : #rendering }
LuiComponent >> renderContentOn: aRenderer [
	self renderSubcomponentsOn: aRenderer
]

{ #category : #rendering }
LuiComponent >> renderSubcomponentsOn: aRenderer [
	self components do: [ :each | each renderComponentOn: aRenderer ]
]
