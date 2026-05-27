Class {
	#name : 'LcsComponentAttributesSubclassAndInstallationBuilder',
	#superclass : 'LcsCodeBuilderJob',
	#instVars : [
		'classPrefix',
		'classRootName',
		'targetPackageName',
		'targetComponentClassName',
		'targetSuperclassName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'builder' }
LcsComponentAttributesSubclassAndInstallationBuilder >> buildJobSteps [
	self addJobStep: self componentAttributesSubclassBuilder.
	self addJobStep: self componentClassDefaultAttributesClassMethodBuilder.
]

{ #category : 'accessing' }
LcsComponentAttributesSubclassAndInstallationBuilder >> classPrefix [
	^ classPrefix
]

{ #category : 'accessing' }
LcsComponentAttributesSubclassAndInstallationBuilder >> classPrefix: anObject [
	classPrefix := anObject
]

{ #category : 'accessing' }
LcsComponentAttributesSubclassAndInstallationBuilder >> classRootName [
	^ classRootName
]

{ #category : 'accessing' }
LcsComponentAttributesSubclassAndInstallationBuilder >> classRootName: anObject [
	classRootName := anObject
]

{ #category : 'builder' }
LcsComponentAttributesSubclassAndInstallationBuilder >> componentAttributesSubclassBuilder [
	^ LcsGenericClassBuilder new
		newTargetClassName: self targetClassName;
		targetPackageName: self targetPackageName;
		targetPackageTagName: self targetPackageTagName;
		targetSuperclassName: self targetSuperclassName; 
		yourself
]

{ #category : 'builder' }
LcsComponentAttributesSubclassAndInstallationBuilder >> componentClassDefaultAttributesClassMethodBuilder [
	^ LcsGenericMethodBuilder new
		targetClassName: self targetComponentClassName;
		categoryName: 'initialize';
		selector: 'componentAttributesClass';
		methodSource: ('componentAttributesClass
	^ <1s>' expandMacrosWith: self targetClassName);
		yourself
]

{ #category : 'as yet unclassified' }
LcsComponentAttributesSubclassAndInstallationBuilder >> installNewClassesInPackageNamed: aString tag: aTagName [
	self targetPackageName: aString.
	self targetPackageTagName: aTagName
]

{ #category : 'builder' }
LcsComponentAttributesSubclassAndInstallationBuilder >> targetClassName [
	^ self classPrefix , self classRootName , 'Attributes'
]

{ #category : 'accessing' }
LcsComponentAttributesSubclassAndInstallationBuilder >> targetComponentClassName [
	^ targetComponentClassName
]

{ #category : 'accessing' }
LcsComponentAttributesSubclassAndInstallationBuilder >> targetComponentClassName: anObject [
	targetComponentClassName := anObject
]

{ #category : 'accessing' }
LcsComponentAttributesSubclassAndInstallationBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : 'accessing' }
LcsComponentAttributesSubclassAndInstallationBuilder >> targetPackageName: anObject [
	targetPackageName := anObject
]

{ #category : 'builder' }
LcsComponentAttributesSubclassAndInstallationBuilder >> targetSuperclassName [
	^ targetSuperclassName ifNil: [ LuiComponentAttributes name ]
]
