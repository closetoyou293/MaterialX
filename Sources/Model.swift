/*
 * Copyright (C) 2015 - 2018, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import CoreData

internal struct ModelIdentifier {
  static let entityName: String = "ManagedEntity"
  static let entityPropertyName: String = "ManagedEntityProperty"
  static let entityTagName: String = "ManagedEntityTag"
  static let entityGroupName: String = "ManagedEntityGroup"
}

internal struct Model {
  /// A static reference to the managedObjectModel.
  static var managedObjectModel: NSManagedObjectModel?
  
  /// Creates a NSManagedObjectModel.
  static func create() -> NSManagedObjectModel {
    _ = Model.__once
    return Model.managedObjectModel!
  }
  
  /// Constructs the model once.
  private static var __once: () = {
    // Entity
    
    let entityDescription = NSEntityDescription()
    var entityProperties : [Any] = []
    entityDescription.name = ModelIdentifier.entityName
    entityDescription.managedObjectClassName = ModelIdentifier.entityName
    
    let entityPropertyDescription = NSEntityDescription()
    var entityPropertyProperties : [Any] = []
    entityPropertyDescription.name = ModelIdentifier.entityPropertyName
    entityPropertyDescription.managedObjectClassName = ModelIdentifier.entityPropertyName
    
    let entityTagDescription = NSEntityDescription()
    var entityTagProperties : [Any] = []
    entityTagDescription.name = ModelIdentifier.entityTagName
    entityTagDescription.managedObjectClassName = ModelIdentifier.entityTagName
    
    let entityGroupDescription = NSEntityDescription()
    var entityGroupProperties : [Any] = []
    entityGroupDescription.name = ModelIdentifier.entityGroupName
    entityGroupDescription.managedObjectClassName = ModelIdentifier.entityGroupName
    
    // nodeClass
    
    let nodeClass = NSAttributeDescription()
    nodeClass.name = "nodeClass"
    nodeClass.attributeType = .integer64AttributeType
    nodeClass.isOptional = false
    entityProperties.append(nodeClass.copy() as! NSAttributeDescription)
    
    // type
    
    let type = NSAttributeDescription()
    type.name = "type"
    type.attributeType = .stringAttributeType
    type.isOptional = false
    entityProperties.append(type.copy() as! NSAttributeDescription)
    
    // createdDate
    
    let createdDate = NSAttributeDescription()
    createdDate.name = "createdDate"
    createdDate.attributeType = .dateAttributeType
    createdDate.isOptional = false
    entityProperties.append(createdDate.copy() as! NSAttributeDescription)
    
    // property
    
    let propertyName = NSAttributeDescription()
    propertyName.name = "name"
    propertyName.attributeType = .stringAttributeType
    propertyName.isOptional = false
    entityPropertyProperties.append(propertyName.copy() as! NSAttributeDescription)
    
    let propertyValue = NSAttributeDescription()
    propertyValue.name = "object"
    propertyValue.attributeType = .transformableAttributeType
    propertyValue.attributeValueClassName = "Any"
    propertyValue.isOptional = false
    propertyValue.allowsExternalBinaryDataStorage = true
    entityPropertyProperties.append(propertyValue.copy() as! NSAttributeDescription)
    
    let propertyRelationship = NSRelationshipDescription()
    propertyRelationship.name = "node"
    propertyRelationship.minCount = 1
    propertyRelationship.maxCount = 1
    propertyRelationship.isOptional = false
    propertyRelationship.deleteRule = .noActionDeleteRule
    
    let propertySetRelationship = NSRelationshipDescription()
    propertySetRelationship.name = "propertySet"
    propertySetRelationship.minCount = 0
    propertySetRelationship.maxCount = 0
    propertySetRelationship.isOptional = false
    propertySetRelationship.deleteRule = .noActionDeleteRule
    propertyRelationship.inverseRelationship = propertySetRelationship
    propertySetRelationship.inverseRelationship = propertyRelationship
    
    propertyRelationship.destinationEntity = entityDescription
    propertySetRelationship.destinationEntity = entityPropertyDescription
    entityPropertyProperties.append(propertyRelationship.copy() as! NSRelationshipDescription)
    entityProperties.append(propertySetRelationship.copy() as! NSRelationshipDescription)
    
    // tag
    
    let tagName = NSAttributeDescription()
    tagName.name = "name"
    tagName.attributeType = .stringAttributeType
    tagName.isOptional = false
    entityTagProperties.append(tagName.copy() as! NSAttributeDescription)
    
    let tagRelationship = NSRelationshipDescription()
    tagRelationship.name = "node"
    tagRelationship.minCount = 1
    tagRelationship.maxCount = 1
    tagRelationship.isOptional = false
    tagRelationship.deleteRule = .noActionDeleteRule
    
    let tagSetRelationship = NSRelationshipDescription()
    tagSetRelationship.name = "tagSet"
    tagSetRelationship.minCount = 0
    tagSetRelationship.maxCount = 0
    tagSetRelationship.isOptional = false
    tagSetRelationship.deleteRule = .noActionDeleteRule
    tagRelationship.inverseRelationship = tagSetRelationship
    tagSetRelationship.inverseRelationship = tagRelationship
    
    tagRelationship.destinationEntity = entityDescription
    tagSetRelationship.destinationEntity = entityTagDescription
    entityTagProperties.append(tagRelationship.copy() as! NSRelationshipDescription)
    entityProperties.append(tagSetRelationship.copy() as! NSRelationshipDescription)
    
    // group
    
    let groupName = NSAttributeDescription()
    groupName.name = "name"
    groupName.attributeType = .stringAttributeType
    groupName.isOptional = false
    entityGroupProperties.append(groupName.copy() as! NSAttributeDescription)
    
    let groupRelationship = NSRelationshipDescription()
    groupRelationship.name = "node"
    groupRelationship.minCount = 1
    groupRelationship.maxCount = 1
    groupRelationship.isOptional = false
    groupRelationship.deleteRule = .noActionDeleteRule
    
    let groupSetRelationship = NSRelationshipDescription()
    groupSetRelationship.name = "groupSet"
    groupSetRelationship.minCount = 0
    groupSetRelationship.maxCount = 0
    groupSetRelationship.isOptional = false
    groupSetRelationship.deleteRule = .noActionDeleteRule
    groupRelationship.inverseRelationship = groupSetRelationship
    groupSetRelationship.inverseRelationship = groupRelationship
    
    groupRelationship.destinationEntity = entityDescription
    groupSetRelationship.destinationEntity = entityGroupDescription
    entityGroupProperties.append(groupRelationship.copy() as! NSRelationshipDescription)
    entityProperties.append(groupSetRelationship.copy() as! NSRelationshipDescription)
    
    entityDescription.properties = entityProperties as! [NSPropertyDescription]
    entityPropertyDescription.properties = entityPropertyProperties as! [NSPropertyDescription]
    entityTagDescription.properties = entityTagProperties as! [NSPropertyDescription]
    entityGroupDescription.properties = entityGroupProperties as! [NSPropertyDescription]
    
    Model.managedObjectModel = NSManagedObjectModel()
    Model.managedObjectModel?.entities = [
      entityDescription,
      entityPropertyDescription,
      entityTagDescription,
      entityGroupDescription
    ]
  }()
}
