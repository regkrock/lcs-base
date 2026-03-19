"
This is for slots that can be read and written by users with the appropriate authority
"
Class {
	#name : 'LcsAccessorSlotBuilder',
	#superclass : 'LcsBaseSlotBuilder',
	#instVars : [
		'comment'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LcsAccessorSlotBuilder class >> newOn: aBuilderOrBuilderJob [
	^ self new
		initializeOn: aBuilderOrBuilderJob;
		yourself 
]

{ #category : 'configuration' }
LcsAccessorSlotBuilder class >> slotClass [
	"Subclasses can override this method to provide a default"
	^ LcsAccessorSlot
]

{ #category : 'gt views' }
LcsAccessorSlotBuilder >> addClassesToUmlModel: aUmlModel [
	aUmlModel addClassNamed: self targetClassName.
	self jobSteps addClassesToUmlModel: aUmlModel.
	self addTargetModuleClassTo: aUmlModel
]

{ #category : 'initialize' }
LcsAccessorSlotBuilder >> addSlotType: aClassOrClassName [
	"Strings are allowed because the class may not yet be created"
	| item |
	item := aClassOrClassName isClass 
					ifTrue: [ aClassOrClassName ] 
					ifFalse: [ (self classNamed: aClassOrClassName) ifNil: [ aClassOrClassName ] ].
	(self slotTypes includes: item) ifFalse: [
		self slotTypes add: item ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> addSlotTypeRule: aRule [
	self slotTypeRules addRule: aRule
]

{ #category : 'gt views' }
LcsAccessorSlotBuilder >> addTargetClassTo: classesModel [
	self targetClass
		ifNil: [ classesModel proposedClassModelFor: self targetClassName ]
		ifNotNil: [ :class | classesModel addClassModelForExisting: class ]
]

{ #category : 'gt views' }
LcsAccessorSlotBuilder >> addTargetModuleClassTo: classesModel [
	self targetModuleClass notNil
		ifTrue: [ classesModel addClassModelForExisting: self targetModuleClass ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> addValidationRule: aRule [
	self validationRules addRule: aRule
]

{ #category : 'slot model' }
LcsAccessorSlotBuilder >> addValidationRuleBlock: aBlock description: aDescription [
	^ self validationRules addRuleBlock: aBlock description: aDescription
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> allowNil [
	^ self propertyAt: 'allowNil' ifAbsent: [ false ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> allowNil: anObject [ 
	self propertyAt: 'allowNil' put: anObject
]

{ #category : 'margritte' }
LcsAccessorSlotBuilder >> allowNilDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Nil';
		priority: 18;
		accessor: #'allowNil';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> allowNull [
	^ self propertyAt: 'allowNull' ifAbsent: [ false ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> allowNull: anObject [ 
	self propertyAt: 'allowNull' put: anObject
]

{ #category : 'margritte' }
LcsAccessorSlotBuilder >> allowNullDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Null';
		priority: 19;
		accessor: #'allowNull';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'magritte - support' }
LcsAccessorSlotBuilder >> beAllowNil [
	self allowNil: true
]

{ #category : 'job steps' }
LcsAccessorSlotBuilder >> buildJobSteps [
	self addJobStep: self slotInstanceVariableBuilder.
	self addJobStep: self slotDefinitionMethodBuilder.
	self addJobStep: self getterAndSetterMethodsBuilder
]

{ #category : 'uninstall' }
LcsAccessorSlotBuilder >> clearTargetClass: aClass [
	self targetClass == aClass
		ifTrue: [ self targetClassName: nil ]
]

{ #category : 'accessing' }
LcsAccessorSlotBuilder >> comment [
	^ self properties at: 'comment' ifAbsent: [ '' ]
]

{ #category : 'accessing' }
LcsAccessorSlotBuilder >> comment: anObject [
	^ self properties at: 'comment' put: anObject
]

{ #category : 'margritte' }
LcsAccessorSlotBuilder >> commentDescription [
	<magritteDescription>
	^ MAStringDescription new
			label: 'Comment';
			priority: 30;
			accessor: #'comment';
			default: '';
			kind: String;
			editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
					"+ (BrGlamorousWithExplicitContextMenuAptitude
							itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
			labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> defaultPrevalidationTransformBlock [
	^ [  ]
]

{ #category : 'initialize' }
LcsAccessorSlotBuilder >> getterAndSetterMethodsBuilder [
	^ LcsSlotGetterAndSetterBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
]

{ #category : 'slot model' }
LcsAccessorSlotBuilder >> getterSelector [
	^ self slotName asSymbol
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> initialValueBlock [
	^ self propertyAt: 'initialValueBlock' ifAbsent: [ [ ] ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> initialValueBlock: aString [
	^ self propertyAt: 'initialValueBlock' put: aString
]

{ #category : 'margritte' }
LcsAccessorSlotBuilder >> initialValueBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: ('Initial Value Block [ :<1s> : <2s> | ' expandMacrosWithArguments: LcsAccessorSlot domainObjectSlotBlockArguments);
		priority: 9;
		default: '';
		accessor: (LcsMABlockPluggableAccessor 
						accessors: #(#initialValueBlock)
						arguments: LcsAccessorSlot domainObjectSlotBlockArguments);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'initialize' }
LcsAccessorSlotBuilder >> initialize [
	super initialize.
	self validationRules: (LcsValidationRules newOn: self).
	self postUpdateActions: (LcsUpdateActions newOn: self)
]

{ #category : 'initialize' }
LcsAccessorSlotBuilder >> initializeOn: aBuilderOrBuilderJob [ 
	self parent: aBuilderOrBuilderJob
]

{ #category : 'job steps' }
LcsAccessorSlotBuilder >> installSlotDefinition [
	self targetClass installAccessorSlotDefinition: self slotDefinitionSelector
]

{ #category : 'testing' }
LcsAccessorSlotBuilder >> isNilAllowed [
	^ self allowNil == true
]

{ #category : 'testing' }
LcsAccessorSlotBuilder >> isNullAllowed [
	^ self allowNull == true
]

{ #category : 'querying' }
LcsAccessorSlotBuilder >> jobStep: anInteger [
	^ self jobSteps jobStep: anInteger
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> postUpdateActions [
	^ self propertyAt: #postUpdateActions ifAbsentPut: [ LcsUpdateAction newOn: self]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> postUpdateActions: anObject [
	self propertyAt: #postUpdateActions put: anObject
]

{ #category : 'margritte' }
LcsAccessorSlotBuilder >> postUpdateActionsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: (MAChainAccessor accessors: #(#postUpdateActions #collection));
		  label: 'Post Update Actions';
		  default: #(  );
		  classes: { LcsUpdateAction };
		  priority: 35;
		  beModifiable;
		  blocItemStencil: [ :anItemViewModel :anItemIndex | 
			  anItemViewModel asElement
				  fitContent;
				  border:
					  (BlBorder
						   paint: BrGlamorousColors disabledButtonBorderColor
						   width: 1);
				  margin: (BlInsets
						   top: 0
						   right: 5
						   bottom: 5
						   left: 0);
				  padding: (BlInsets all: 5);
				  background: Color white ];
		  newItemStencil: [ LcsUpdateAction new
		  						parent: self postUpdateActions;
		  						yourself ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> prevalidationTransformBlock [
	^ self propertyAt: 'prevalidationTransformBlock' ifAbsent: [ self defaultPrevalidationTransformBlock ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> prevalidationTransformBlock: aString [
	^ self propertyAt: 'prevalidationTransformBlock' put: aString
]

{ #category : 'margritte' }
LcsAccessorSlotBuilder >> prevalidationTransformBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Prevalidation Transform Block [ :value :slot | ';
		priority: 11;
		default: '';
		accessor: (LcsMABlockPluggableAccessor 
						accessors: #(#prevalidationTransformBlock )
						arguments: LcsAccessorSlot valueSlotBlockArguments);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'validations' }
LcsAccessorSlotBuilder >> removeValidationRule: aRule [
	self validationRules removeRule: aRule
]

{ #category : 'validations' }
LcsAccessorSlotBuilder >> removeValidationRuleWithDescription: aString [
	self validationRules removeRuleWithDescription: aString
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> required [
	^ self propertyAt: 'required' ifAbsent: [ false ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> required: anObject [ 
	self propertyAt: 'required' put: anObject
]

{ #category : 'margritte' }
LcsAccessorSlotBuilder >> requiredDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Required';
		priority: 9;
		accessor: #required;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'initialize' }
LcsAccessorSlotBuilder >> slotInstanceVariableBuilder [
	^ LcsSlotInstanceVariableBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> slotTypeRules [
	^ self propertyAt: #slotTypeRules ifAbsentPut: [ LcsSlotTypeRules newOn: self]
]

{ #category : 'verification' }
LcsAccessorSlotBuilder >> targetSlotDefinition [
	^ self targetClass perform: self slotDefinitionSelector
]

{ #category : 'command' }
LcsAccessorSlotBuilder >> updateSlotModel [
	super updateSlotModel.
	self installSlotDefinition
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> validationRuleItems [
	^ self propertyAt: #validationRuleItems ifAbsentPut: [ OrderedCollection new]
]

{ #category : 'margritte' }
LcsAccessorSlotBuilder >> validationRuleItemsDescription [
	"<magritteDescription>"
	^ MAToManyRelationDescription new
		  accessor: #validationRuleItems;
		  "accessor: #validationConditions;"
		  label: 'Validation Conditions';
"		  default: #( LcsValidationCondition );"
		  classes: { LcsValidationRule };
		  priority: 25;
		  beModifiable;
		  blocItemStencil: [ :anItemViewModel :anItemIndex | 
			  anItemViewModel asElement
				  fitContent;
				  border:
					  (BlBorder
						   paint: BrGlamorousColors disabledButtonBorderColor
						   width: 1);
				  margin: (BlInsets
						   top: 0
						   right: 5
						   bottom: 5
						   left: 0);
				  padding: (BlInsets all: 5);
				  background: Color white ];
		  newItemStencil: [  LcsValidationRule new ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> validationRules [
	^ self propertyAt: #validationRules ifAbsentPut: [ LcsValidationRules newOn: self]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> validationRules: anObject [
	self propertyAt: #validationRules put: anObject.
	"self validationConditionItems: anObject collection copy"
]

{ #category : 'margritte' }
LcsAccessorSlotBuilder >> validationRulesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: (MAChainAccessor accessors: #(#validationRules #collection));
		  label: 'Relationship Rules';
		  default: #(  );
		  classes: { LcsValidationRule };
		  priority: 25;
		  beModifiable;
		  blocItemStencil: [ :anItemViewModel :anItemIndex | 
			  anItemViewModel asElement
				  fitContent;
				  border:
					  (BlBorder
						   paint: BrGlamorousColors disabledButtonBorderColor
						   width: 1);
				  margin: (BlInsets
						   top: 0
						   right: 5
						   bottom: 5
						   left: 0);
				  padding: (BlInsets all: 5);
				  background: Color white ];
		  "addCondition: [ :aValue | true ] labelled: 'Individual Conditions Are Not Valid';"
		  newItemStencil: [  LcsValidationRule new ]
]

{ #category : 'properties' }
LcsAccessorSlotBuilder >> validationRulesItems: aCollection [
	self propertyAt: #validationRuleItems put: aCollection.
	self validationRules removeAll.
	aCollection do: [:each | self validationRules addRule: each ]
]

{ #category : 'gt views' }
LcsAccessorSlotBuilder >> viewCodeButton [
	self targetClass isNil ifTrue: [ ^ BrButton new ].
	^ self viewClassButtonFor: self targetClass 
]
