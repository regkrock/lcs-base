Class {
	#name : 'LcsSystemBuilderForm',
	#superclass : 'LcsBaseSlotCreationForm',
	#category : 'Lcs-Magritte-Base-Forms - Models',
	#package : 'Lcs-Magritte-Base',
	#tag : 'Forms - Models'
}

{ #category : 'configuration' }
LcsSystemBuilderForm class >> builderClass [
	^ LcsSystemBuilderJob
]

{ #category : 'magritte' }
LcsSystemBuilderForm >> classNamePrefixDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Name Prefix';
		priority: 2;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder classPrefix));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : 'magritte' }
LcsSystemBuilderForm >> classRootNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Root Name';
		priority: 3;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder classRootName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 3 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : 'magritte' }
LcsSystemBuilderForm >> decorateTargetClassDescription: aMgritteDescription [ 
	aMgritteDescription
		addCondition: [ :aValue | | aClass | 
			[aClass := aValue asString trim asClass.
			 (aClass = LcsSystem or: [ aClass inheritsFrom: LcsSystem ]) ] 
				on: NotFound 
				do: [ :s | s return: false ] ]
			labelled: 'Must be a LcsSystem or a subclass of LcsSystem'
]

{ #category : 'initialize' }
LcsSystemBuilderForm >> initializeOn: aTarget [
	self targetClass: (aTarget isClass ifTrue: [ aTarget ] ifFalse: [ aTarget class ]).
	self targetClassName: self targetClass name asString.
	self slotModelBuilder targetPackageName: ''.
	self slotModelBuilder targetPackageTagName: ''
]

{ #category : 'testing' }
LcsSystemBuilderForm >> isSlotModelBuilderNotReified [
	^ self slotModelBuilder class = self builderClass
]

{ #category : 'magritte' }
LcsSystemBuilderForm >> moduleNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'System Name';
		priority: 15;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder moduleName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : 'magritte - support' }
LcsSystemBuilderForm >> targetClassLabel [
	^'New System is subclass of'
]

{ #category : 'magritte' }
LcsSystemBuilderForm >> targetPackageNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Package';
		priority: 8;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder targetPackageName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : 'magritte' }
LcsSystemBuilderForm >> targetPackageTagNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Package Tag';
		priority: 9;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder targetPackageTagName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]
