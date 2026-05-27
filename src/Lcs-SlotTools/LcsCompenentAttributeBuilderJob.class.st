Class {
	#name : 'LcsCompenentAttributeBuilderJob',
	#superclass : 'LcsCodeBuilderJob',
	#instVars : [
		'classPrefix',
		'classRootName',
		'targetPackageName',
		'attributeName',
		'tagAttributeSetSelector',
		'componentAttributesClassName',
		'componentClassName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'private' }
LcsCompenentAttributeBuilderJob >> _attributeName [
	^ self attributeName ifNil: [ self classRootName asValidSelector ]
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> attributeGetterInComponentAttributesBuilder [
	^ LcsAttributeGetterInComponentAttributesBuilder new
		"targetClass: self componentAttributesClassName asClass;"
		targetClassName: self componentAttributesClassName;
		selector: (self _attributeName , 'Attribute') asSymbol;
		attributeClassName: self targetClassName;
		yourself
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> attributeGetterSelector [
	^ self _attributeName asValidSelector asSymbol
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> attributeGetterToComponentClassBuilder [
	^ LcsAttributeValueGetterInComponentBuilder new
		targetClassName: self componentClassName;
		selector: self attributeGetterSelector;
		categoryName: 'accessing - attribute';
		yourself
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> attributeName [
	^ attributeName
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> attributeName: anObject [
	attributeName := anObject
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> attributeNameMethodBuilder [
	^ LcsGenericMethodBuilder new
		targetClassName: self targetClassName;
		selector: #attributeName;
		methodSource: self attributeNameMethodSourceCode;
		beClassMethod;
		yourself
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> attributeNameMethodSourceCode [
	^ 'attributeName
	^ <1p>' expandMacrosWith: self _attributeName
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> attributeSetterSelector [
	^ (self _attributeName asValidSelector , ':') asSymbol
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> attributeSetterToComponentClassBuilder [
	^ LcsAttributeValueSetterInComponentBuilder new
		targetClassName: self componentClassName;
		selector: self attributeSetterSelector;
		categoryName: 'accessing - attribute';
		yourself
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> attributeValueGetterInComponentAttributesBuilder [
	^ LcsAttributeValueGetterInComponentAttributesBuilder new
		"targetClass: self componentAttributesClassName asClass;"
		targetClassName: self componentAttributesClassName;
		selector: self attributeGetterSelector;
		yourself
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> attributeValueSetterInComponentAttributesBuilder [
	^ LcsAttributeValueSetterInComponentAttributesBuilder new
		"targetClass: self componentAttributesClassName asClass;"
		targetClassName: self componentAttributesClassName;
		attributeName: self _attributeName;
		selector: self attributeSetterSelector;
		yourself
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> buildJobSteps [
	self addJobStep: self componentAttributeClassBuilder.
	self addJobStep: self componentAttributeGetterBuilder.
	self addJobStep: self componentAttributeSetterBuilder.
	self addJobStep: self attributeNameMethodBuilder.
	self hasTagAttributeSetterSelector ifTrue: [ 
		self addJobStep: self tagAttributeSetterSelectorBuilder ].
	self addJobStep: self attributeGetterInComponentAttributesBuilder.
	self addJobStep: self attributeValueGetterInComponentAttributesBuilder.
	self addJobStep: self attributeValueSetterInComponentAttributesBuilder.
	self addJobStep: self hasAttributeMethodInComponentAttributesBuilder.
	self hasComponentClassName ifTrue: [
		self addJobStep: self attributeGetterToComponentClassBuilder.
		self addJobStep: self attributeSetterToComponentClassBuilder]
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> classPrefix [
	^ classPrefix
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> classPrefix: anObject [
	classPrefix := anObject
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> classRootName [
	^ classRootName
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> classRootName: aRootName [ 
	classRootName := aRootName
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> componentAttributeClassBuilder [
	^ LcsComponentAttributeClassBuilder new
		newTargetClassName: self targetClassName;
		targetPackageName: self targetPackageName;
		targetPackageTagName: self targetPackageTagName;
		yourself
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> componentAttributeGetterBuilder [
	^ LcsComponentAttributeGetterBuilder new
		targetClassName: self targetClassName;
		selector: self attributeGetterSelector
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> componentAttributeSetterBuilder [
	^ LcsComponentAttributeSetterBuilder new
		targetClassName: self targetClassName;
		selector: self attributeSetterSelector
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> componentAttributesClassName [
	^ componentAttributesClassName
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> componentAttributesClassName: anObject [
	componentAttributesClassName := anObject
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> componentClassName [
	^ componentClassName
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> componentClassName: anObject [
	componentClassName := anObject
]

{ #category : 'as yet unclassified' }
LcsCompenentAttributeBuilderJob >> createForRootName: aRootName [
	self classRootName: aRootName
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> hasAttributeMethodInComponentAttributesBuilder [
	^ LcsHasAttributeMethodInComponentAttributesBuilder new
		"targetClass: self componentAttributesClassName asClass;"
		targetClassName: self componentAttributesClassName;
		attributeClassName: self targetClassName;
		selector: self hasAttributeSelector;
		yourself
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> hasAttributeSelector [
	^ ('has<1s>Attribute' expandMacrosWith: self classRootName) asSymbol
]

{ #category : 'testsing' }
LcsCompenentAttributeBuilderJob >> hasComponentClassName [
	^ self componentClassName notNil
		and: [ self componentClassName notEmpty ]
]

{ #category : 'testsing' }
LcsCompenentAttributeBuilderJob >> hasTagAttributeSetterSelector [
	^ self tagAttributeSetterSelector notNil
		and: [ self tagAttributeSetterSelector notEmpty ]
]

{ #category : 'configuration' }
LcsCompenentAttributeBuilderJob >> installNewClassesInPackageNamed: aString [ 
	self targetPackageName: aString
]

{ #category : 'configuration' }
LcsCompenentAttributeBuilderJob >> installNewClassesInPackageNamed: aString tag: aTagName [
	self targetPackageName: aString.
	self targetPackageTagName: aTagName
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> tagAttributeSetterSelector [
	^ tagAttributeSetSelector
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> tagAttributeSetterSelector: anObject [
	tagAttributeSetSelector := anObject
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> tagAttributeSetterSelectorBuilder [
	^ LcsGenericMethodBuilder new
		targetClassName: self targetClassName;
		selector: #tagAttributeSetterSelector;
		methodSource: self tagAttributeSetterSelectorSourceCode;
		yourself
]

{ #category : 'builder' }
LcsCompenentAttributeBuilderJob >> tagAttributeSetterSelectorSourceCode [
	^ 'tagAttributeSetterSelector
	^ <1p>' expandMacrosWith: self tagAttributeSetterSelector
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> targetClassName [
	^ self classPrefix , self classRootName , 'Attribute'
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : 'accessing' }
LcsCompenentAttributeBuilderJob >> targetPackageName: aString [ 
	targetPackageName := aString
]
